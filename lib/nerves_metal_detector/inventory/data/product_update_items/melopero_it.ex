defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.MeloperoIt do
  alias NervesMetalDetector.Vendors.MeloperoIt.ProductUpdate

  @items [
    # RPi 3
    %ProductUpdate{
      url: "https://www.melopero.com/shop/raspberry-pi/boards/raspberrypi3modela/",
      sku: "RPI3-MODAP"
    },

    # RPi 4
    %ProductUpdate{
      url:
        "https://www.melopero.com/en/shop/raspberry-pi/boards/raspberrypi4computermodelb2gbram/",
      sku: "RPI4-MODBP-2GB"
    },

    # RPi Zero 2
    %ProductUpdate{
      url: "https://www.melopero.com/shop/raspberry-pi/raspberry-pi-zero-2-w/",
      sku: "SC0510"
    }
  ]

  def all(), do: @items
end
