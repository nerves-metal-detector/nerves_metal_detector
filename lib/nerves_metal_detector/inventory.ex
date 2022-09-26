defmodule NervesMetalDetector.Inventory do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  alias NervesMetalDetector.Repo
  alias NervesMetalDetector.Inventory.Data
  alias NervesMetalDetector.Inventory.ProductAvailability

  def products(), do: Data.Products.all()

  def get_product_by_sku(sku), do: Data.Products.get_by_sku(String.downcase(sku))

  def product_update_items(), do: Data.ProductUpdateItems.all()

  def list_product_availabilities() do
    query =
      from pa in ProductAvailability,
        order_by: [desc: :in_stock, asc: :sku],
        select: pa

    Repo.all(query)
  end

  def fetch_product_availability(args) do
    ProductAvailability.Fetcher.fetch_availability(args)
  end

  def store_product_availability(attrs) do
    ProductAvailability.store(attrs)
  end
end
