defmodule NervesMetalDetector.Jobs.ScheduleProductAvailabilitySnapshotsPurges do
  use Oban.Worker,
    queue: :product_availability_snapshots_purge,
    max_attempts: 1

  alias NervesMetalDetector.Vendors
  alias NervesMetalDetector.Inventory.Data.ProductUpdateItems
  alias NervesMetalDetector.Jobs.ProductAvailabilitySnapshotsPurge

  @impl Oban.Worker
  def perform(_job) do
    vendors = Vendors.all()

    for vendor <- vendors do
      {:ok, product_update_items} = ProductUpdateItems.get_by_vendor(vendor)

      for item <- product_update_items do
        ProductAvailabilitySnapshotsPurge.new(%{vendor: vendor.id, sku: item.sku})
        |> Oban.insert()
      end
    end

    :ok
  end
end
