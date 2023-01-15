defmodule NervesMetalDetectorWeb.HomeLive do
  use NervesMetalDetectorWeb, :live_view

  alias NervesMetalDetector.Inventory
  alias NervesMetalDetector.Inventory.ProductAvailability
  alias NervesMetalDetector.Vendors
  alias NervesMetalDetectorWeb.ProductAvailabilitiesTableComponent

  def render(assigns) do
    ~H"""
    <section>
      <div class="bg-white rounded-lg mb-2 pb-2 overflow-hidden">
        <.live_component
          module={ProductAvailabilitiesTableComponent}
          id="product-availabilities"
          items={@initial_product_availabilities}
        />
      </div>

      <div class="bg-white rounded-lg mb-10 flex flex-row text-slate-900">
        <div class="basis-1/3 text-center p-1.5 border-r-2 border-r-slate-100">
          <div class="text-2xl"><%= @vendors_count %></div>
          <div class="text-slate-500">Vendors</div>
        </div>
        <div class="basis-1/3 text-center p-1.5 border-r-2 border-r-slate-100">
          <div class="text-2xl"><%= @products_count %></div>
          <div class="text-slate-500">Products</div>
        </div>
        <div class="basis-1/3 text-center p-1.5">
          <div class="text-2xl"><%= @items_count %></div>
          <div class="text-slate-500">Items</div>
        </div>
      </div>
    </section>
    """
  end

  def mount(_params, _session, socket) do
    product_availabilities =
      Inventory.list_product_availabilities()
      |> Enum.filter(fn i -> i.product_info !== nil && i.vendor_info !== nil end)

    if connected?(socket) do
      for pa <- product_availabilities do
        Phoenix.PubSub.subscribe(
          NervesMetalDetector.PubSub,
          ProductAvailability.pub_sub_topic(pa)
        )
      end
    end

    vendors_count = Enum.count(Vendors.all())
    products_count = Enum.count(Inventory.products())
    items_count = Enum.count(product_availabilities)

    title = page_title()

    meta_attrs = [
      %{name: "title", content: title},
      %{
        name: "description",
        content:
          "Find hardware compatible with Nerves, the Elixir based framework for embedded systems"
      }
    ]

    socket =
      socket
      |> assign(page_title: title, meta_attrs: meta_attrs)
      |> assign(:initial_product_availabilities, product_availabilities)
      |> assign(:vendors_count, vendors_count)
      |> assign(:products_count, products_count)
      |> assign(:items_count, items_count)

    {:ok, socket, temporary_assigns: [initial_product_availabilities: []]}
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
