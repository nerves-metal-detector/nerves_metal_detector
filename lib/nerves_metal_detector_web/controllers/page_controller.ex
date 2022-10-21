defmodule NervesMetalDetectorWeb.PageController do
  use NervesMetalDetectorWeb, :controller

  alias NervesMetalDetector.Inventory
  alias NervesMetalDetector.Vendors

  def index(conn, _params) do
    product_availabilities =
      Inventory.list_product_availabilities()
      |> hydrate_and_filter()

    vendors_count = Enum.count(Vendors.all())
    products_count = Enum.count(Inventory.products())
    items_count = Enum.count(product_availabilities)

    render(conn, "index.html",
      product_availabilities: product_availabilities,
      vendors_count: vendors_count,
      products_count: products_count,
      items_count: items_count
    )
  end

  defp hydrate_and_filter(items) do
    # probably add product and vendor as virtual field to the schema and hydrate in context module
    items
    |> Enum.map(fn i ->
      product =
        case Inventory.get_product_by_sku(i.sku) do
          {:ok, product} -> product
          _ -> nil
        end

      vendor =
        case Vendors.get_by_id(i.vendor) do
          {:ok, vendor} -> vendor
          _ -> nil
        end

      Map.from_struct(i)
      |> Map.put(:product, product)
      |> Map.put(:vendor, vendor)
    end)
    |> Enum.filter(fn i -> i.product !== nil && i.vendor !== nil end)
  end
end
