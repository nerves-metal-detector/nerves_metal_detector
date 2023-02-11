defmodule NervesMetalDetectorWeb.VendorLive do
  use NervesMetalDetectorWeb, :live_view

  alias NervesMetalDetector.Inventory
  alias NervesMetalDetector.Inventory.ProductAvailability
  alias NervesMetalDetector.Vendors
  alias NervesMetalDetector.Vendors.Vendor
  alias NervesMetalDetectorWeb.ProductAvailabilitiesTableComponent
  alias NervesMetalDetectorWeb.NotFoundError

  def render(assigns) do
    ~H"""
    <section>
      <div class="bg-white rounded-lg mb-10 py-2 overflow-hidden">
        <div class="mx-2 pb-3 border-b">
          <h2 class="text-xl">
            <%= Vendor.display_name(@vendor) %>
          </h2>
          <div class="text-xs">
            <a href={@vendor.homepage} target="_blank" class="hover:text-blue-500">
              Go to vendor homepage
              <Heroicons.arrow_top_right_on_square mini class="w-3.5 h-3.5 inline" />
            </a>
          </div>
        </div>

        <.live_component
          module={ProductAvailabilitiesTableComponent}
          id="product-availabilities"
          items={@initial_product_availabilities}
          hidden_columns={[:vendor]}
        />
      </div>
    </section>
    """
  end

  def mount(params, _session, socket) do
    with vendor_id when not is_nil(vendor_id) <- params["vendor"],
         {:ok, vendor} <- Vendors.get_by_id(vendor_id) do
      product_availabilities =
        Inventory.list_product_availabilities([{:where, [vendor: vendor.id]}])

      if connected?(socket) do
        for pa <- product_availabilities do
          Phoenix.PubSub.subscribe(
            NervesMetalDetector.PubSub,
            ProductAvailability.pub_sub_topic(pa)
          )
        end
      end

      title = page_title(Vendor.display_name(vendor))

      meta_attrs = [
        %{name: "title", content: title},
        %{
          name: "description",
          content:
            "Find products at #{vendor.homepage} compatible with Nerves, the Elixir based framework for embedded systems"
        }
      ]

      socket =
        socket
        |> assign(page_title: title, meta_attrs: meta_attrs)
        |> assign(:vendor, vendor)
        |> assign(:initial_product_availabilities, product_availabilities)

      {:ok, socket, temporary_assigns: [initial_product_availabilities: []]}
    else
      _ -> raise NotFoundError
    end
  end

  def handle_info({:update_product_availability, pa}, socket) do
    send_update(ProductAvailabilitiesTableComponent,
      id: "product-availabilities",
      items: [pa],
      patch: true
    )

    {:noreply, socket}
  end
end
