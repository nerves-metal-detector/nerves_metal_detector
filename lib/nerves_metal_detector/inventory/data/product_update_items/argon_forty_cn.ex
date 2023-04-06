defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.ArgonFortyCn do
  alias NervesMetalDetector.Vendors.ArgonFortyCn.ProductUpdate

  @items [
    # RPi 4
    %ProductUpdate{
      url: "https://argon40.com/products/raspberry-pi-4-board-only?variant=39730177998913",
      sku: "RPI4-MODBP-8GB"
    },
    %ProductUpdate{
      url: "https://argon40.com/products/raspberry-pi-4-board-only?variant=39730177966145",
      sku: "RPI4-MODBP-4GB"
    },
    %ProductUpdate{
      url: "https://argon40.com/products/raspberry-pi-4-board-only?variant=39730177933377",
      sku: "RPI4-MODBP-2GB"
    },
    %ProductUpdate{
      url: "https://argon40.com/products/raspberry-pi-4-board-only?variant=39730177900609",
      sku: "RPI4-MODBP-1GB"
    },

    # RPi Zero
    %ProductUpdate{
      url: "https://argon40.com/products/raspberry-pi-zero-w-board?variant=39735277715521",
      sku: "SC0020"
    },
    %ProductUpdate{
      url: "https://argon40.com/products/raspberry-pi-zero-wh-board?variant=39735277748289",
      sku: "SC0020WH"
    },

    # RPi Zero 2
    %ProductUpdate{
      url: "https://argon40.com/products/raspberry-pi-zero-2-w-board?variant=39735277682753",
      sku: "SC0510"
    }
  ]

  def all(), do: @items
end
