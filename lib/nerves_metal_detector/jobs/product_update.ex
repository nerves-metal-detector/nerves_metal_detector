defmodule NervesMetalDetector.Jobs.ProductUpdate do
  use Oban.Worker,
    queue: :product_updates,
    max_attempts: 3

  require Logger

  @impl Oban.Worker
  def perform(%Oban.Job{args: args}) do
     Logger.info("product update #{inspect(args)}}")

    :ok
  end
end
