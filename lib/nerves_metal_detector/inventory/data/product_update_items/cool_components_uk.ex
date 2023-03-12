defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.CoolComponentsUk do
  alias NervesMetalDetector.Vendors.CoolComponentsUk.ProductUpdate

  @items [
    # RPi 3
    %ProductUpdate{
      url: "https://coolcomponents.co.uk/products/raspberry-pi-3-model-a",
      sku: "RPI3-MODAP"
    },
    %ProductUpdate{
      url: "https://coolcomponents.co.uk/products/raspberry-pi-3-model-b-1",
      sku: "RPI3-MODBP"
    },

    # RPi 4
    %ProductUpdate{
      url: "https://coolcomponents.co.uk/products/raspberry-pi-4?variant=29215479595069",
      sku: "RPI4-MODBP-2GB"
    },
    %ProductUpdate{
      url: "https://coolcomponents.co.uk/products/raspberry-pi-4?variant=29215479627837",
      sku: "RPI4-MODBP-4GB"
    },
    %ProductUpdate{
      url: "https://coolcomponents.co.uk/products/raspberry-pi-4?variant=32889923633213",
      sku: "RPI4-MODBP-8GB"
    },

    # RPi Zero
    %ProductUpdate{
      url: "https://coolcomponents.co.uk/products/raspberry-pi-zero-w",
      sku: "SC0020"
    },
    %ProductUpdate{
      url: "https://coolcomponents.co.uk/products/raspberry-pi-zero-wh-pre-soldered",
      sku: "SC0020WH"
    },

    # RPi Zero 2
    %ProductUpdate{
      url: "https://coolcomponents.co.uk/products/raspberry-pi-zero-2-w",
      sku: "SC0510"
    }
  ]

  def all(), do: @items
end
