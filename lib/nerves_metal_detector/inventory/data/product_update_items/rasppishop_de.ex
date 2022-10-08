defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.RasppishopDe do
  alias NervesMetalDetector.Vendors.RasppishopDe.ProductUpdate

  @items [
    # RPi 4
    %ProductUpdate{
      url: "https://www.rasppishop.de/Raspberry-Pi-4-Modell-B-2GB-SDRAM",
      sku: "RPI4-MODBP-2GB"
    },
    %ProductUpdate{
      url: "https://www.rasppishop.de/Raspberry-Pi-4-Modell-B-1GB-SDRAM",
      sku: "RPI4-MODBP-1GB"
    },
    %ProductUpdate{
      url: "https://www.rasppishop.de/Raspberry-Pi-4-Modell-B-4GB-SDRAM",
      sku: "RPI4-MODBP-4GB"
    },
    %ProductUpdate{
      url: "https://www.rasppishop.de/Raspberry-Pi-4-Computer-Modell-B-8GB-SDRAM",
      sku: "RPI4-MODBP-8GB"
    },

    # RPi Zero 2
    %ProductUpdate{url: "https://www.rasppishop.de/Raspberry-Pi-Zero-2-W", sku: "SC0510"}
  ]

  def all(), do: @items
end
