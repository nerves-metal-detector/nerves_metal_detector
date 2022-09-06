defmodule NervesMetalDetector.Jobs.ScheduleProductUpdates do
  use Oban.Worker,
    queue: :product_updates,
    max_attempts: 1

  require Logger

  alias NervesMetalDetector.Jobs.ProductUpdate

  @impl Oban.Worker
  def perform(_job) do
     Logger.info("schedule product updates")

     1..5
     |> Enum.map(fn x -> %{id: x} end)
     |> Enum.map(&ProductUpdate.new/1)
     |> Enum.each(&Oban.insert/1)

    :ok
  end
end
