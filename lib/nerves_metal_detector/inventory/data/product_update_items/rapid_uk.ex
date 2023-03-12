defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.RapidUk do
  alias NervesMetalDetector.Vendors.RapidUk.ProductUpdate

  @items [
    # RPi 3
    %ProductUpdate{
      url:
        "https://www.rapidonline.com/raspberry-pi-3-model-a-512mb-quad-core-wifi-bluetooth-75-1006",
      sku: "RPI3-MODAP"
    },
    %ProductUpdate{
      url:
        "https://www.rapidonline.com/raspberry-pi-3-model-b-1-quad-core-1-4ghz-1gb-ram-wifi-bluetooth-75-1005",
      sku: "RPI3-MODBP"
    },

    # RPi 4
    %ProductUpdate{
      url: "https://www.rapidonline.com/raspberry-pi-4-model-b-2gb-75-1007",
      sku: "RPI4-MODBP-2GB"
    },
    %ProductUpdate{
      url: "https://www.rapidonline.com/raspberry-pi-4-model-b-4gb-75-1008",
      sku: "RPI4-MODBP-4GB"
    },
    %ProductUpdate{
      url: "https://www.rapidonline.com/raspberry-pi-4-model-b-8gb-75-1013",
      sku: "RPI4-MODBP-8GB"
    },

    # RPi Zero 2
    %ProductUpdate{
      url: "https://www.rapidonline.com/raspberry-pi-zero-2-w-75-2230",
      sku: "SC0510"
    }
  ]

  def all(), do: @items
end
