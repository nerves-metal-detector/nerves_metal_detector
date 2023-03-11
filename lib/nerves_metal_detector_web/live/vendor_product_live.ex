defmodule NervesMetalDetectorWeb.VendorProductLive do
  use NervesMetalDetectorWeb, :live_view

  import Ecto.Query, only: [dynamic: 2]

  alias NervesMetalDetector.Inventory
  alias NervesMetalDetector.Inventory.ProductAvailability
  alias NervesMetalDetector.Vendors
  alias NervesMetalDetector.Vendors.Vendor
  alias NervesMetalDetectorWeb.UPlotComponent
  alias NervesMetalDetectorWeb.VendorProductAvailabilityChart
  alias NervesMetalDetectorWeb.NotFoundError

  def render(assigns) do
    ~H"""
    <section>
      <div class="bg-white rounded-lg mb-10 py-2 overflow-hidden">
        <div class="mx-2 pb-3 border-b grid grid-cols-none sm:grid-cols-[1fr_auto] gap-4">
          <div>
            <h2 class="text-xl">
              <.link navigate={~p"/vendor/#{@vendor}"} class="hover:text-blue-500">
                <%= Vendor.display_name(@vendor) %>
              </.link>
              <.icon name="hero-chevron-right" class={["w-5 h-5"]} />
              <.link navigate={~p"/product/#{@product}"} class="hover:text-blue-500">
                <%= @product.name %>
              </.link>
            </h2>
            <div class="text-xs">
              Last updated:
              <.date_time
                id="fetched_at"
                date_time={@product_availability.fetched_at}
                format="MMM dd, HH:mm"
                js_format="MMM dd, HH:mm"
              />
            </div>
          </div>
          <div>
            <a
              href={@product_availability.url}
              target="_blank"
              class="inline-block py-1 px-2 rounded-lg bg-blue-900 text-white hover:bg-blue-800 w-full"
            >
              <div :if={@product_availability.in_stock}>
                <div class="text-xs text-white">
                  <span :if={!@product_availability.items_in_stock}>In stock</span>
                  <span :if={@product_availability.items_in_stock}>
                    <%= @product_availability.items_in_stock %> in stock
                  </span>
                  <.icon name="hero-check" class="w-4 h-4 -mt-1" />
                </div>
                <div class="text-md font-bold leading-tight">
                  Buy at <%= Vendor.display_name(@vendor) %> for <%= @product_availability.price %>
                </div>
              </div>
              <div :if={!@product_availability.in_stock}>
                <div class="text-xs text-white">Not in stock</div>
                <div class="text-md font-bold leading-tight">
                  See at <%= Vendor.display_name(@vendor) %> for <%= @product_availability.price %>
                </div>
              </div>
            </a>
          </div>
        </div>
        <.live_component
          module={UPlotComponent}
          id="availability-chart"
          height={200}
          live_interval={1000}
        />
        <div class="mx-2 mt-3 pt-3 border-t">
          <div><%= @product.description %>.</div>
          <div :if={Enum.count(@product.tags) > 0} class="flex flex-wrap gap-2 mt-2">
            <span
              :for={tag <- @product.tags}
              class="py-1 px-1.5 rounded text-xs bg-blue-100 text-blue-600"
            >
              <%= tag %>
            </span>
          </div>
        </div>
      </div>
    </section>
    """
  end

  def mount(params, _session, socket) do
    with vendor_id when not is_nil(vendor_id) <- params["vendor"],
         sku when not is_nil(sku) <- params["sku"],
         {:ok, vendor} <- Vendors.get_by_id(vendor_id),
         {:ok, product} <- Inventory.get_product_by_sku(sku),
         [product_availability] <-
           Inventory.list_product_availabilities([{:where, [vendor: vendor.id, sku: product.sku]}]) do
      if connected?(socket) do
        Phoenix.PubSub.subscribe(
          NervesMetalDetector.PubSub,
          ProductAvailability.pub_sub_topic(product_availability)
        )

        send(self(), :load_chart)
      end

      title = page_title("#{product.name} at #{Vendor.display_name(vendor)}")

      meta_attrs = [
        %{name: "title", content: title},
        %{
          name: "description",
          content: "Information and availability of #{product.name} at #{vendor.homepage}"
        }
      ]

      socket =
        socket
        |> assign(page_title: title, meta_attrs: meta_attrs)
        |> assign(:vendor, vendor)
        |> assign(:product, product)
        |> assign(:product_availability, product_availability)
        |> assign(:mount_time, DateTime.now!("Etc/UTC"))

      {:ok, socket}
    else
      _ -> raise NotFoundError
    end
  end

  def handle_info(:load_chart, socket) do
    {:ok, task} =
      Task.start(__MODULE__, :load_chart, [self(), socket.assigns.product_availability])

    monitor = Process.monitor(task)

    {:noreply, socket |> assign(:chart_loading_monitor, monitor)}
  end

  def handle_info({:update_product_availability, pa}, socket) do
    has_count_result =
      Inventory.list_product_availability_snapshots(
        dynamic(
          [s],
          s.vendor == ^pa.vendor_info.id and s.sku == ^pa.product_info.sku and s.in_stock == true and
            not is_nil(s.items_in_stock) and s.fetched_at < ^socket.assigns.mount_time
        ),
        1
      )

    stock =
      case Enum.count(has_count_result) do
        1 ->
          case pa.in_stock do
            true -> pa.items_in_stock || 1
            false -> 0
          end

        0 ->
          pa.in_stock
      end

    new_data_set = [
      DateTime.to_unix(pa.fetched_at),
      stock,
      Decimal.to_float(Money.to_decimal(pa.price))
    ]

    send_update(UPlotComponent, id: "availability-chart", new_data_set: new_data_set)
    {:noreply, assign(socket, :product_availability, pa)}
  end

  def handle_info(
        {:DOWN, monitor, :process, _object, reason},
        %{assigns: %{chart_loading_monitor: monitor}} = socket
      ) do
    if reason !== :normal do
      send(self(), :load_chart)
    end

    {:noreply, socket |> assign(:chart_loading_monitor, nil)}
  end

  def load_chart(pid, %ProductAvailability{vendor_info: vendor, product_info: product}) do
    snapshots = Inventory.list_product_availability_snapshots(vendor: vendor.id, sku: product.sku)
    chart_payload = VendorProductAvailabilityChart.payload(snapshots)

    send_update(pid, UPlotComponent, id: "availability-chart", chart_payload: chart_payload)
  end
end
