defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.PimoroniUk do
  alias NervesMetalDetector.Vendors.PimoroniUk.ProductUpdate

  @items [
    # RPi 3
    %ProductUpdate{
      url: "https://shop.pimoroni.com/products/raspberry-pi-3-a-plus?variant=17989206507603",
      sku: "RPI3-MODAP"
    },
    %ProductUpdate{
      url: "https://shop.pimoroni.com/products/raspberry-pi-3-b-plus?variant=2600826929162",
      sku: "RPI3-MODBP"
    },

    # RPi 4
    %ProductUpdate{
      url: "https://shop.pimoroni.com/products/raspberry-pi-4?variant=29157087412307",
      sku: "RPI4-MODBP-2GB"
    },
    %ProductUpdate{
      url: "https://shop.pimoroni.com/products/raspberry-pi-4?variant=29157087445075",
      sku: "RPI4-MODBP-4GB"
    },
    %ProductUpdate{
      url: "https://shop.pimoroni.com/products/raspberry-pi-4?variant=31856486416467",
      sku: "RPI4-MODBP-8GB"
    },
    %ProductUpdate{
      url: "https://shop.pimoroni.com/products/raspberry-pi-4?variant=39576373690451",
      sku: "RPI4-MODBP-1GB"
    },

    # RPi CM4
    %ProductUpdate{
      url:
        "https://shop.pimoroni.com/products/raspberry-pi-compute-module-4?variant=32280530813011",
      sku: "CM4104000"
    },
    %ProductUpdate{
      url:
        "https://shop.pimoroni.com/products/raspberry-pi-compute-module-4?variant=32280530911315",
      sku: "CM4104032"
    },
    %ProductUpdate{
      url:
        "https://shop.pimoroni.com/products/raspberry-pi-compute-module-4?variant=32280531075155",
      sku: "CM4001000"
    },
    %ProductUpdate{
      url:
        "https://shop.pimoroni.com/products/raspberry-pi-compute-module-4?variant=32280531173459",
      sku: "CM4001032"
    },

    # RPi Zero
    %ProductUpdate{
      url: "https://shop.pimoroni.com/products/raspberry-pi-zero-w?variant=39458414264403",
      sku: "SC0020"
    },
    %ProductUpdate{
      url: "https://shop.pimoroni.com/products/raspberry-pi-zero-w?variant=39458414297171",
      sku: "SC0020WH"
    },

    # RPi Zero 2
    %ProductUpdate{url: "https://shop.pimoroni.com/products/raspberry-pi-zero-2-w", sku: "SC0510"}
  ]

  def all(), do: @items
end
