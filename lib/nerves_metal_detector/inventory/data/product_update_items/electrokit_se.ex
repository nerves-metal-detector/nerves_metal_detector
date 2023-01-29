defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.ElectrokitSe do
  alias NervesMetalDetector.Vendors.ElectrokitSe.ProductUpdate

  @items [
    # RPi 3
    %ProductUpdate{
      url: "https://www.electrokit.com/en/product/raspberry-pi-3-model-a",
      sku: "RPI3-MODAP"
    },
    %ProductUpdate{
      url: "https://www.electrokit.com/en/product/raspberry-pi-3-1gb-model-b-3",
      sku: "RPI3-MODBP"
    },

    # RPi 4
    %ProductUpdate{
      url: "https://www.electrokit.com/en/product/raspberry-pi-4-model-b-1gb",
      sku: "RPI4-MODBP-1GB"
    },
    %ProductUpdate{
      url: "https://www.electrokit.com/en/product/raspberry-pi-4-model-b-4gb",
      sku: "RPI4-MODBP-4GB"
    },
    %ProductUpdate{
      url: "https://www.electrokit.com/en/product/raspberry-pi-4-model-b-2gb",
      sku: "RPI4-MODBP-2GB"
    },
    %ProductUpdate{
      url: "https://www.electrokit.com/en/product/raspberry-pi-4-model-b-8gb",
      sku: "RPI4-MODBP-8GB"
    },

    # RPi Zero 2
    %ProductUpdate{url: "https://www.electrokit.com/en/product/pzw2/", sku: "SC0510"}
  ]

  def all(), do: @items
end
