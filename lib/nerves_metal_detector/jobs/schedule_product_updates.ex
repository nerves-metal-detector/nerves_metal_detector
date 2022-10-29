defmodule NervesMetalDetector.Jobs.ScheduleProductUpdates do
  use Oban.Worker,
    queue: :product_updates,
    max_attempts: 1

  require Logger

  @impl Oban.Worker
  def perform(_job) do
    NervesMetalDetector.schedule_product_updates()

    :ok
  end
end
