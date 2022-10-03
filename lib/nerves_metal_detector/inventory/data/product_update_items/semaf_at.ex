defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.SemafAt do
  alias NervesMetalDetector.Vendors.SemafAt.ProductUpdate

  @items [
    # RPi 4
    %ProductUpdate{
      url: "https://electronics.semaf.at/Raspberry-Pi-4-4GB-Board",
      sku: "RPI4-MODBP-4GB"
    },
    %ProductUpdate{
      url: "https://electronics.semaf.at/Raspberry-Pi-4-8GB-Board",
      sku: "RPI4-MODBP-8GB"
    },

    # RPi Zero 2
    %ProductUpdate{
      url: "https://electronics.semaf.at/Raspberry-Pi-Zero-2-WHC-Stiftleisten-Farbkodiert",
      sku: "SC0510WH"
    },
    %ProductUpdate{
      url: "https://electronics.semaf.at/Raspberry-Pi-Zero-2-W",
      sku: "SC0510"
    }
  ]

  def all(), do: @items
end
