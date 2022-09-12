defmodule NervesMetalDetector.Jobs.ScheduleProductUpdates do
  use Oban.Worker,
    queue: :product_updates,
    max_attempts: 1

  require Logger

  alias NervesMetalDetector.Jobs.ProductUpdate
  alias NervesMetalDetector.Vendors.BerryBaseDe

  @impl Oban.Worker
  def perform(_job) do
    [
      %BerryBaseDe.ProductUpdate{
        url: "https://www.berrybase.de/raspberry-pi-4-computer-modell-b-1gb-ram",
        sku: "RPI4-MODBP-1GB"
      },
      %BerryBaseDe.ProductUpdate{
        url: "https://www.berrybase.de/raspberry-pi-4-computer-modell-b-2gb-ram",
        sku: "RPI4-MODBP-2GB"
      },
      %BerryBaseDe.ProductUpdate{
        url: "https://www.berrybase.de/raspberry-pi-4-computer-modell-b-4gb-ram",
        sku: "RPI4-MODBP-4GB"
      },
      %BerryBaseDe.ProductUpdate{
        url: "https://www.berrybase.de/raspberry-pi-4-computer-modell-b-8gb-ram",
        sku: "RPI4-MODBP-8GB"
      }
    ]
    |> Enum.map(&ProductUpdate.encode_args/1)
    |> Enum.map(&ProductUpdate.new/1)
    |> Enum.map(&Oban.insert/1)

    :ok
  end
end
