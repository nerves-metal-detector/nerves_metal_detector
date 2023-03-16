defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.PiShopCh do
  alias NervesMetalDetector.Vendors.PiShopCh.ProductUpdate

  @items [
    # RPi 4
    %ProductUpdate{
      url: "https://www.pi-shop.ch/raspberry-pi-4-model-b-1gb",
      sku: "RPI4-MODBP-1GB"
    },
    %ProductUpdate{
      url: "https://www.pi-shop.ch/raspberry-pi-4-model-b-2gb",
      sku: "RPI4-MODBP-2GB"
    },
    %ProductUpdate{
      url: "https://www.pi-shop.ch/raspberry-pi-4-model-b-4gb",
      sku: "RPI4-MODBP-4GB"
    },
    %ProductUpdate{
      url: "https://www.pi-shop.ch/raspberry-pi-4-model-b-8gb",
      sku: "RPI4-MODBP-8GB"
    },

    # RPi 3
    %ProductUpdate{url: "https://www.pi-shop.ch/raspberry-pi-3-model-a", sku: "RPI3-MODAP"},
    %ProductUpdate{url: "https://www.pi-shop.ch/raspberry-pi-3-model-b", sku: "RPI3-MODBP"},

    # RPi CM3
    %ProductUpdate{
      url:
        "https://www.pi-shop.ch/cm3-lite-single-board-computer-raspberry-pi-compute-module-3-lite-bcm2837b0-soc",
      sku: "CM3+Lite"
    },
    %ProductUpdate{
      url:
        "https://www.pi-shop.ch/cm3-8gb-single-board-computer-raspberry-pi-compute-module-3-bcm2837b0-soc-8gb-emmc-memory",
      sku: "CM3+8GB"
    },
    %ProductUpdate{
      url:
        "https://www.pi-shop.ch/cm3-16gb-single-board-computer-raspberry-pi-compute-module-3-bcm2837b0-soc-16gb-emmc-memory",
      sku: "CM3+16GB"
    },
    %ProductUpdate{
      url:
        "https://www.pi-shop.ch/cm3-32gb-single-board-computer-raspberry-pi-compute-module-3-bcm2837b0-soc-32gb-emmc-memory",
      sku: "CM3+32GB"
    },

    # RPi CM4
    %ProductUpdate{
      url:
        "https://www.pi-shop.ch/raspberry-pi-compute-module-4-and-io-board-4-gb-ram-8gb-emmc-wireless",
      sku: "CM4104008"
    },
    %ProductUpdate{
      url:
        "https://www.pi-shop.ch/raspberry-pi-compute-module-4-and-io-board-4gb-16gb-emmc-wireless",
      sku: "CM4104016"
    },
    %ProductUpdate{
      url:
        "https://www.pi-shop.ch/raspberry-pi-compute-module-4-and-io-board-4-gb-ram-32gb-emmc-wireless",
      sku: "CM4104032"
    },
    %ProductUpdate{
      url: "https://www.pi-shop.ch/raspberry-pi-compute-module-4-and-io-board-2-gb-ram-lite",
      sku: "CM4002000"
    },
    %ProductUpdate{
      url:
        "https://www.pi-shop.ch/raspberry-pi-compute-module-4-and-io-board-4-gb-ram-lite-wireless",
      sku: "CM4104000"
    },
    %ProductUpdate{
      url: "https://www.pi-shop.ch/raspberry-pi-compute-module-4-4-gb-ram-16gb-emmc",
      sku: "CM4004016"
    },
    %ProductUpdate{
      url:
        "https://www.pi-shop.ch/raspberry-pi-compute-module-4-and-io-board-2-gb-ram-16gb-emmc-wireless",
      sku: "CM4102016"
    },

    # RPi Zero
    %ProductUpdate{url: "https://www.pi-shop.ch/raspberry-pi-zero-w-1811", sku: "SC0020"},

    # RPi Zero 2
    %ProductUpdate{url: "https://www.pi-shop.ch/raspberry-pi-zero-2-w", sku: "SC0510"}
  ]

  def all(), do: @items
end
