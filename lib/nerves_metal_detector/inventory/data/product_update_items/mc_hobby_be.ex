defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.McHobbyBe do
  alias NervesMetalDetector.Vendors.McHobbyBe.ProductUpdate

  @items [
    # RPi Zero 2
    %ProductUpdate{
      url:
        "https://shop.mchobby.be/en/pi-zero-12wwh/2297-raspberry-pi-zero-2-wireless-cam-conn-3232100022973.html",
      sku: "SC0510"
    },

    # RPi 3
    %ProductUpdate{
      url:
        "https://shop.mchobby.be/en/raspberry-pi-3/1326-raspberry-pi-3-b-plus-in-stock--3232100013261.html",
      sku: "RPI3-MODBP"
    },
    %ProductUpdate{
      url:
        "https://shop.mchobby.be/en/raspberry-pi-3/1425-raspberry-pi-3-a-plus-3232100014251.html",
      sku: "RPI3-MODAP"
    },

    # RPi 4
    %ProductUpdate{
      url:
        "https://shop.mchobby.be/en/raspberry-pi-4/1608-raspberry-pi-4-1-go-de-ram-in-stock--3232100016088.html",
      sku: "RPI4-MODBP-1GB"
    },
    %ProductUpdate{
      url:
        "https://shop.mchobby.be/en/raspberry-pi-4/1609-raspberry-pi-4-2-go-de-ram-in-stock--3232100016095.html",
      sku: "RPI4-MODBP-2GB"
    },
    %ProductUpdate{
      url:
        "https://shop.mchobby.be/en/raspberry-pi-4/1610-raspberry-pi-4-4-go-de-ram-in-stock--3232100016101.html",
      sku: "RPI4-MODBP-4GB"
    },
    %ProductUpdate{
      url:
        "https://shop.mchobby.be/en/raspberry-pi-4/1858-raspberry-pi-4-8-go-de-ram-in-stock--3232100018587.html",
      sku: "RPI4-MODBP-8GB"
    }
  ]

  def all(), do: @items
end
