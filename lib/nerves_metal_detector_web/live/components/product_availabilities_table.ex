defmodule NervesMetalDetectorWeb.ProductAvailabilitiesTableComponent do
  use NervesMetalDetectorWeb, :live_component

  def render(assigns) do
    ~H"""
    <table class="w-full">
      <tr>
        <th class="py-3 px-1.5 text-left font-medium">SKU</th>
        <th class="py-3 px-1.5 text-left font-medium">Name</th>
        <th class="py-3 px-1.5 text-left font-medium">In Stock (#)</th>
        <th class="py-3 px-1.5 text-left font-medium">Price</th>
        <th class="py-3 px-1.5 text-left font-medium">Vendor</th>
        <th class="py-3 px-1.5 text-left font-medium">Updated (UTC)</th>
        <th class="py-3 px-1.5 text-left font-medium">Link</th>
      </tr>
      <tbody id={"#{@id}-table-body"} phx-update={@update}>
        <tr
          :for={item <- @items}
          id={"#{item.vendor_info.id}-#{item.sku}"}
          class={[
            "hover:bg-slate-100 text-slate-500",
            item.in_stock &&
              "bg-blue-50 hover:bg-blue-100 !text-slate-900 border-x-8 border-x-blue-300"
          ]}
        >
          <td class="p-1.5"><%= item.sku %></td>
          <td class="p-1.5"><%= item.product_info.name %></td>
          <td class="p-1.5">
            <span :if={item.in_stock}>
              <Heroicons.check :if={item.in_stock} mini class="w-5 h-5 inline" />
              <span :if={item.items_in_stock}><%= "(#{item.items_in_stock})" %></span>
            </span>
            <Heroicons.x_mark :if={!item.in_stock} mini class="w-5 h-5 inline" />
          </td>
          <td class="p-1.5"><%= item.price %></td>
          <td class="p-1.5">
            <%= "#{item.vendor_info.name} (#{item.vendor_info.country |> Atom.to_string() |> String.upcase()})" %>
          </td>
          <td class="p-1.5">
            <%= NervesMetalDetector.Cldr.DateTime.to_string!(item.fetched_at, format: "MMM dd, HH:mm") %>
          </td>
          <td class="p-1.5">
            <a href={item.url} target="_blank" class="hover:text-blue-500">
              <Heroicons.arrow_top_right_on_square mini class="w-5 h-5 inline" />
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

    socket = socket |> assign(assigns) |> assign(:update, update)

    {:ok, socket}
  end
end
