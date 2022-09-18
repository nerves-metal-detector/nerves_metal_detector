defmodule NervesMetalDetector.Inventory do
  @moduledoc false

  alias NervesMetalDetector.Inventory.Data
  alias NervesMetalDetector.Inventory.ProductAvailability

  def products(), do: Data.Products.all()

  def product_update_items(), do: Data.ProductUpdateItems.all()

  def fetch_product_availability(args) do
    ProductAvailability.Fetcher.fetch_availability(args)
  end

  def store_product_availability(attrs) do
    ProductAvailability.store(attrs)
  end
end
