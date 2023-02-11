defmodule NervesMetalDetectorWeb.ProductLive do
  use NervesMetalDetectorWeb, :live_view

  alias NervesMetalDetector.Inventory
  alias NervesMetalDetector.Inventory.ProductAvailability
  alias NervesMetalDetectorWeb.ProductAvailabilitiesTableComponent
  alias NervesMetalDetectorWeb.NotFoundError

  def render(assigns) do
    ~H"""
    <section>
      <div class="bg-white rounded-lg mb-10 py-2 overflow-hidden">
        <div class="mx-2 pb-3 border-b">
          <h2 class="text-xl">
            <%= @product.name %>
          </h2>
          <div class="text-xs">
            <%= @product.description %>
          </div>
          <div :if={Enum.count(@product.tags) > 0} class="flex flex-wrap gap-2 mt-2">
            <span
              :for={tag <- @product.tags}
              class="py-1 px-1.5 rounded text-xs bg-blue-100 text-blue-600"
            >
              <%= tag %>
            </span>
          </div>
        </div>

        <.live_component
          module={ProductAvailabilitiesTableComponent}
          id="product-availabilities"
          items={@initial_product_availabilities}
          hidden_columns={[:sku, :name]}
        />
      </div>
    </section>
    """
  end

  def mount(params, _session, socket) do
    with sku when not is_nil(sku) <- params["sku"],
         {:ok, product} <- Inventory.get_product_by_sku(sku) do
      product_availabilities =
        Inventory.list_product_availabilities([{:where, [sku: product.sku]}])

      if connected?(socket) do
        for pa <- product_availabilities do
          Phoenix.PubSub.subscribe(
            NervesMetalDetector.PubSub,
            ProductAvailability.pub_sub_topic(pa)
          )
        end
      end

      title = page_title(product.name)

      meta_attrs = [
        %{name: "title", content: title},
        %{
          name: "description",
          content: "Find information on where to buy #{product.name}"
        }
      ]

      socket =
        socket
        |> assign(page_title: title, meta_attrs: meta_attrs)
        |> assign(:product, product)
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
