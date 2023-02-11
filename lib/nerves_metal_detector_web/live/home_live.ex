defmodule NervesMetalDetectorWeb.HomeLive do
  use NervesMetalDetectorWeb, :live_view

  alias NervesMetalDetector.Inventory
  alias NervesMetalDetector.Inventory.ProductAvailability
  alias NervesMetalDetector.Vendors
  alias NervesMetalDetectorWeb.ProductAvailabilitiesTableComponent
  alias NervesMetalDetectorWeb.PaginationComponent

  @per_page 50

  def render(assigns) do
    ~H"""
    <section>
      <div class="bg-white rounded-lg mb-2 pb-2 overflow-hidden">
        <.live_component
          module={ProductAvailabilitiesTableComponent}
          id="product-availabilities"
          items={@initial_product_availabilities}
        />

        <PaginationComponent.render
          page={@page}
          total_pages={@total_pages}
          jump_to={:top}
          class="mx-auto mt-2 px-2"
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
    vendors_count = Enum.count(Vendors.all())
    products_count = Enum.count(Inventory.products())
    total_product_availabilities = Inventory.count_product_availabilities()

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
      |> assign(:vendors_count, vendors_count)
      |> assign(:products_count, products_count)
      |> assign(:items_count, total_product_availabilities)
      |> assign(:pa_pub_sub_topics, [])
      |> assign(:page, 1)
      |> assign(
        :total_pages,
        PaginationComponent.total_pages(total_product_availabilities, @per_page)
      )

    {:ok, socket, temporary_assigns: [initial_product_availabilities: []]}
  end

  def handle_params(params, _url, socket) do
    for topic <- socket.assigns.pa_pub_sub_topics do
      Phoenix.PubSub.unsubscribe(NervesMetalDetector.PubSub, topic)
    end

    page = PaginationComponent.parse_page(params)

    product_availabilities =
      Inventory.list_product_availabilities([{:paginate, %{page: page, per_page: @per_page}}])

    pa_pub_sub_topics = Enum.map(product_availabilities, &ProductAvailability.pub_sub_topic/1)

    if connected?(socket) do
      for topic <- pa_pub_sub_topics do
        Phoenix.PubSub.subscribe(NervesMetalDetector.PubSub, topic)
      end
    end

    socket =
      socket
      |> assign(:initial_product_availabilities, product_availabilities)
      |> assign(:pa_pub_sub_topics, pa_pub_sub_topics)
      |> assign(:page, page)

    {:noreply, socket}
  end

  def handle_info({:update_product_availability, pa}, socket) do
    if ProductAvailability.pub_sub_topic(pa) in socket.assigns.pa_pub_sub_topics do
      send_update(ProductAvailabilitiesTableComponent,
        id: "product-availabilities",
        items: [pa],
        patch: true
      )
    end

    {:noreply, socket}
  end
end
