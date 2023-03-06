defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.MeloperoIt do
  alias NervesMetalDetector.Vendors.MeloperoIt.ProductUpdate

  @items [
    # RPi 3
    %ProductUpdate{
      url: "https://www.melopero.com/shop/raspberry-pi/raspberrypi3modela/",
      sku: "RPI3-MODAP"
    },

    # RPi 4
    %ProductUpdate{
      url: "https://www.melopero.com/shop/raspberry-pi/boards/raspberrypi4computermodelb1gbram/",
      sku: "RPI4-MODBP-1GB"
    },
    %ProductUpdate{
      url: "https://www.melopero.com/shop/raspberry-pi/boards/raspberrypi4computermodelb2gbram/",
      sku: "RPI4-MODBP-2GB"
    },
    %ProductUpdate{
      url: "https://www.melopero.com/shop/raspberry-pi/boards/raspberrypi4computermodelb4gbram/",
      sku: "RPI4-MODBP-4GB"
    },
    %ProductUpdate{
      url: "https://www.melopero.com/shop/raspberry-pi/boards/raspberrypi4computermodelb8gbram/",
      sku: "RPI4-MODBP-8GB"
    },

    # RPi Zero
    %ProductUpdate{
      url: "https://www.melopero.com/shop/raspberry-pi/raspberrypizerow/",
      sku: "SC0020"
    },
    %ProductUpdate{
      url:
        "https://www.melopero.com/shop/raspberry-pi/raspberrypizerowhconheaderpresaldato/",
      sku: "SC0020WH"
    },

    # RPi Zero 2
    %ProductUpdate{
      url: "https://www.melopero.com/shop/raspberry-pi/raspberry-pi-zero-2-w/",
      sku: "SC0510"
    }
  ]

  def all(), do: @items
end
