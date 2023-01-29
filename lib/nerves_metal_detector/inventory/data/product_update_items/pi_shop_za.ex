defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.PiShopZa do
  alias NervesMetalDetector.Vendors.PiShopZa.ProductUpdate

  @items [
    # RPi 3
    %ProductUpdate{
      url: "https://www.pishop.co.za/store/raspberry-pi-3-model-b-plus",
      sku: "RPI3-MODBP"
    },

    # RPi 4
    %ProductUpdate{
      url: "https://www.pishop.co.za/store/raspberry-pi-4-model-b-1gb",
      sku: "RPI4-MODBP-1GB"
    },
    %ProductUpdate{
      url: "https://www.pishop.co.za/store/raspberry-pi-4-model-b-2gb",
      sku: "RPI4-MODBP-2GB"
    },
    %ProductUpdate{
      url: "https://www.pishop.co.za/store/raspberry-pi-4-model-b-4gb",
      sku: "RPI4-MODBP-4GB"
    },
    %ProductUpdate{
      url: "https://www.pishop.co.za/store/raspberry-pi-4-model-b-8gb",
      sku: "RPI4-MODBP-8GB"
    },

    # RPi Zero 2
    %ProductUpdate{url: "https://www.pishop.co.za/store/raspberry-pi-zero-2-w", sku: "SC0510"},
    %ProductUpdate{
      url: "https://www.pishop.co.za/store/raspberry-pi-zero-2-w-with-pre-soldered-header",
      sku: "SC0510WH"
    }
  ]

  def all(), do: @items
end
