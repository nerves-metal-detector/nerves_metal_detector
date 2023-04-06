defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.RaspberryPiDk do
  alias NervesMetalDetector.Vendors.RaspberryPiDk.ProductUpdate

  @items [
    # RPi 3
    %ProductUpdate{
      url: "https://raspberrypi.dk/produkt/raspberry-pi-3-model-a-plus/",
      sku: "RPI3-MODAP"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/produkt/raspberry-pi-3-model-b-plus/",
      sku: "RPI3-MODBP"
    },

    # RPi 4
    %ProductUpdate{
      url: "https://raspberrypi.dk/produkt/raspberry-pi-4-model-b-1-gb/",
      sku: "RPI4-MODBP-1GB"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/produkt/raspberry-pi-4-model-b-2-gb/",
      sku: "RPI4-MODBP-2GB"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/produkt/raspberry-pi-4-model-b-4-gb/",
      sku: "RPI4-MODBP-4GB"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/produkt/raspberry-pi-4-model-b-8-gb/",
      sku: "RPI4-MODBP-8GB"
    },

    # RPi Zero
    %ProductUpdate{
      url: "https://raspberrypi.dk/produkt/raspberry-pi-zero-w/",
      sku: "SC0020"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/produkt/raspberry-pi-zero-wh-paaloddet-header/",
      sku: "SC0020WH"
    },

    # RPi Zero 2
    %ProductUpdate{
      url: "https://raspberrypi.dk/produkt/raspberry-pi-zero-2-w/",
      sku: "SC0510"
    }
  ]

  def all(), do: @items
end
