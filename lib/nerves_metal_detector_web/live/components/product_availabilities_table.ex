defmodule NervesMetalDetectorWeb.ProductAvailabilitiesTableComponent do
  use NervesMetalDetectorWeb, :live_component

  alias NervesMetalDetector.Vendors.Vendor

  def render(assigns) do
    ~H"""
    <table class="w-full" id={@id}>
      <tr>
        <th :if={shown?(@hidden_columns, :sku)} class="py-3 px-1.5 text-left font-medium">SKU</th>
        <th :if={shown?(@hidden_columns, :name)} class="py-3 px-1.5 text-left font-medium">Name</th>
        <th :if={shown?(@hidden_columns, :in_stock)} class="py-3 px-1.5 text-left font-medium">
          In Stock (#)
        </th>
        <th :if={shown?(@hidden_columns, :price)} class="py-3 px-1.5 text-left font-medium">Price</th>
        <th :if={shown?(@hidden_columns, :vendor)} class="py-3 px-1.5 text-left font-medium">
          Vendor
        </th>
        <th :if={shown?(@hidden_columns, :updated)} class="py-3 px-1.5 text-left font-medium">
          Updated
        </th>
        <th :if={shown?(@hidden_columns, :links)} class="py-3 px-1.5 text-left font-medium">Links</th>
      </tr>
      <tbody id={"#{@id}-table-body"} phx-update={@update}>
        <tr
          :for={item <- @items}
          id={"#{item.vendor_info.id}-#{item.sku}"}
          class={[
            "hover:bg-slate-100 text-slate-500 text-sm",
            item.in_stock &&
              "bg-slate-50 hover:bg-blue-100 !text-slate-900 !text-base drop-shadow-mds"
          ]}
        >
          <td :if={shown?(@hidden_columns, :sku)} class="p-1.5">
            <.link navigate={~p"/product/#{item.product_info}"} class="hover:text-blue-500">
              <%= item.sku %>
              <.icon name="hero-link-mini" class="w-4 h-4" />
            </.link>
          </td>
          <td :if={shown?(@hidden_columns, :name)} class="p-1.5"><%= item.product_info.name %></td>
          <td :if={shown?(@hidden_columns, :in_stock)} class="p-1.5">
            <span :if={item.in_stock}>
              <.icon name="hero-check-mini" class="w-5 h-5 text-blue-500" />
              <span :if={item.items_in_stock}><%= "(#{item.items_in_stock})" %></span>
            </span>
            <.icon :if={!item.in_stock} name="hero-x-mark-mini" class="w-4 h-4" />
          </td>
          <td :if={shown?(@hidden_columns, :price)} class="p-1.5"><%= item.price %></td>
          <td :if={shown?(@hidden_columns, :vendor)} class="p-1.5">
            <.link navigate={~p"/vendor/#{item.vendor_info}"} class="hover:text-blue-500">
              <%= Vendor.display_name(item.vendor_info) %>
              <.icon name="hero-link-mini" class="w-4 h-4" />
            </.link>
          </td>
          <td :if={shown?(@hidden_columns, :updated)} class="p-1.5">
            <.date_time
              id={"#{item.vendor_info.id}-#{item.sku}-fetched_at"}
              date_time={item.fetched_at}
              format="MMM dd, HH:mm"
              js_format="MMM dd, HH:mm"
            />
          </td>
          <td :if={shown?(@hidden_columns, :links)} class="p-1.5">
            <.link
              navigate={~p"/vendor/#{item.vendor_info}/#{item.product_info}"}
              class="hover:text-blue-500"
            >
              <.icon
                name="hero-information-circle"
                class={[
                  "w-4 h-4",
                  item.in_stock &&
                    "!w-5 !h-5"
                ]}
              />
            </.link>
            <a href={item.url} target="_blank" class="hover:text-blue-500">
              <.icon
                name="hero-arrow-top-right-on-square-mini"
                class={[
                  "w-4 h-4",
                  item.in_stock &&
                    "!w-5 !h-5"
                ]}
              />
            </a>
          </td>
        </tr>
      </tbody>
    </table>
    """
  end

  def update(assigns, socket) do
    update =
      case assigns[:patch] do
        true -> "append"
        _ -> "replace"
      end

    socket =
      socket
      |> assign(assigns)
      |> assign(:update, update)
      |> assign_new(:hidden_columns, fn -> [] end)

    {:ok, socket}
  end

  defp shown?(hidden_columns, column_name) do
    !Enum.member?(hidden_columns, column_name)
  end
end
