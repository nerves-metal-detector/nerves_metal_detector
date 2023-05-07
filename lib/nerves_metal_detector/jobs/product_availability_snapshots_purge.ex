defmodule NervesMetalDetector.Jobs.ProductAvailabilitySnapshotsPurge do
  use Oban.Worker,
    queue: :product_availability_snapshots_purge,
    max_attempts: 3

  import Ecto.Query, only: [dynamic: 2]

  alias NervesMetalDetector.Inventory
  alias NervesMetalDetector.Inventory.ProductAvailabilitySnapshot
  alias NervesMetalDetector.TimeSeries
  alias NervesMetalDetector.Repo

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"vendor" => vendor, "sku" => sku}}) do
    snapshots = list_snapshots(vendor, sku)

    {_, to_delete} =
      TimeSeries.consecutive_dedup(snapshots, fn %ProductAvailabilitySnapshot{} = snapshot,
                                                 _index,
                                                 _total_count ->
        {DateTime.to_date(snapshot.fetched_at), snapshot.price, snapshot.items_in_stock,
         snapshot.in_stock}
      end)

    for snapshot <- to_delete do
      Process.sleep(50)
      Repo.delete(snapshot)
    end

    :ok
  end

  defp list_snapshots(vendor, sku) do
    two_weeks_ago =
      DateTime.now!("Etc/UTC")
      |> DateTime.to_date()
      |> Date.add(-13)
      |> DateTime.new!(Time.new!(0, 0, 0), "Etc/UTC")

    Inventory.list_product_availability_snapshots(
      dynamic(
        [s],
        s.vendor == ^vendor and s.sku == ^sku and s.fetched_at < ^two_weeks_ago
      )
    )
  end
end
