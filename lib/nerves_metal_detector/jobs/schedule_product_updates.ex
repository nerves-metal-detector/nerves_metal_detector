defmodule NervesMetalDetector.Jobs.ScheduleProductUpdates do
  use Oban.Worker,
    queue: :product_updates,
    max_attempts: 1

  require Logger

  alias NervesMetalDetector.Jobs.ProductUpdate
  alias NervesMetalDetector.Inventory

  @impl Oban.Worker
  def perform(_job) do
    Inventory.product_update_items()
    |> Enum.map(&ProductUpdate.encode_args/1)
    |> Enum.map(&ProductUpdate.new/1)
    |> Enum.map(&Oban.insert/1)

    :ok
  end
end
