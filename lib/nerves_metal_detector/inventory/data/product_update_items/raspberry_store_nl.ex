defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.RaspberryStoreNl do
  alias NervesMetalDetector.Vendors.RaspberryStoreNl.ProductUpdate

  @items [
    # RPi 3
    %ProductUpdate{
      url:
        "https://www.raspberrystore.nl/PrestaShop/en/individual-parts/211-raspberry-pi-3-model-a-0652508442181.html",
      sku: "RPI3-MODAP"
    },
    %ProductUpdate{
      url:
        "https://www.raspberrystore.nl/PrestaShop/en/raspberry-pi-v3b/191-raspberry-pi-perfection-3-model-b-0713179640259.html",
      sku: "RPI3-MODBP"
    },

    # RPi 4
    %ProductUpdate{
      url:
        "https://www.raspberrystore.nl/PrestaShop/en/raspberry-pi-v4/227-raspberry-pi-4b2gb-765756931175.html",
      sku: "RPI4-MODBP-2GB"
    },
    %ProductUpdate{
      url:
        "https://www.raspberrystore.nl/PrestaShop/en/raspberry-pi-v4/228-raspberry-pi-4b1gb-765756931182.html",
      sku: "RPI4-MODBP-4GB"
    },
    %ProductUpdate{
      url:
        "https://www.raspberrystore.nl/PrestaShop/en/raspberry-pi-v4/279-raspberry-pi-4b1gb-765756931199.html",
      sku: "RPI4-MODBP-8GB"
    },

    # RPi Zero 2
    %ProductUpdate{
      url:
        "https://www.raspberrystore.nl/PrestaShop/en/raspberry-pi-zero-2/373-raspberry-pi-zero-2-2021-5056561800004.html",
      sku: "SC0510"
    }
  ]

  def all(), do: @items
end
