defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.ElektorNl do
  alias NervesMetalDetector.Vendors.ElektorNl.ProductUpdate

  @items [
    # RPi 4
    %ProductUpdate{
      url: "https://www.elektor.nl/raspberry-pi-4-b-1-gb-ram",
      sku: "RPI4-MODBP-1GB"
    },
    %ProductUpdate{
      url: "https://www.elektor.nl/raspberry-pi-4-b-2-gb-ram",
      sku: "RPI4-MODBP-1GB"
    },
    %ProductUpdate{
      url: "https://www.elektor.nl/raspberry-pi-4-b-4-gb-ram",
      sku: "RPI4-MODBP-1GB"
    },
    %ProductUpdate{
      url: "https://www.elektor.nl/raspberry-pi-4-b-8-gb-ram",
      sku: "RPI4-MODBP-8GB"
    },

    # RPi Zero
    %ProductUpdate{url: "https://www.elektor.nl/raspberry-pi-zero-w", sku: "SC0020"},

    # RPi Zero 2
    %ProductUpdate{url: "https://www.elektor.nl/raspberry-pi-zero-2-w", sku: "SC0510"}
  ]

  def all(), do: @items
end
