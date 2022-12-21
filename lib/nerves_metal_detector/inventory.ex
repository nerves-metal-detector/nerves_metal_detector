defmodule NervesMetalDetector.Inventory do
  @moduledoc false

  import Ecto.Query, only: [from: 2]

  alias NervesMetalDetector.Repo
  alias NervesMetalDetector.Inventory.Data
  alias NervesMetalDetector.Inventory.ProductAvailability
  alias NervesMetalDetector.Inventory.ProductAvailabilitySnapshot
  alias NervesMetalDetector.Vendors

  def products(), do: Data.Products.all()

  def get_product_by_sku(sku), do: Data.Products.get_by_sku(String.downcase(sku))

  def product_update_items(), do: Data.ProductUpdateItems.all()

  def list_product_availabilities() do
    query =
      from pa in ProductAvailability,
        order_by: [desc: :in_stock, asc: :sku, asc: :vendor],
        select: pa

    Repo.all(query)
    |> Enum.map(&hydrate_product_availability/1)
  end

  def hydrate_product_availability(product_availability) do
    product =
      case get_product_by_sku(product_availability.sku) do
        {:ok, product} -> product
        _ -> nil
      end

    vendor =
      case Vendors.get_by_id(product_availability.vendor) do
        {:ok, vendor} -> vendor
        _ -> nil
      end

    product_availability
    |> Map.put(:vendor_info, vendor)
    |> Map.put(:product_info, product)
  end

  def fetch_product_availability(args) do
    ProductAvailability.Fetcher.fetch_availability(args)
  end

  def store_product_availability(attrs) do
    {:ok, pa} = ProductAvailability.store(attrs)
    {:ok, _} = ProductAvailabilitySnapshot.store(attrs)

    pa = hydrate_product_availability(pa)

    Phoenix.PubSub.broadcast(
      NervesMetalDetector.PubSub,
      ProductAvailability.pub_sub_topic(pa),
      {:update_product_availability, pa}
    )

    {:ok, pa}
  end
end
