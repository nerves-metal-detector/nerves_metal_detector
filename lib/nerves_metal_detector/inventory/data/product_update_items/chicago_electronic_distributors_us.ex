defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.ChicagoElectronicDistributorsUs do
  alias NervesMetalDetector.Vendors.ChicagoElectronicDistributorsUs.ProductUpdate

  @items [
    # RPi 3
    %ProductUpdate{
      url: "https://chicagodist.com/products/raspberry-pi-3-model-a",
      sku: "RPI3-MODAP"
    },
    %ProductUpdate{
      url: "https://chicagodist.com/products/raspberry-pi-model-3-b-1-4-ghz",
      sku: "RPI3-MODBP"
    },

    # RPi 4
    %ProductUpdate{
      url: "https://chicagodist.com/products/raspberry-pi-4-model-b-1gb",
      sku: "RPI4-MODBP-1GB"
    },
    %ProductUpdate{
      url: "https://chicagodist.com/products/raspberry-pi-4-model-b-2gb",
      sku: "RPI4-MODBP-2GB"
    },
    %ProductUpdate{
      url: "https://chicagodist.com/products/raspberry-pi-4-model-b-4gb",
      sku: "RPI4-MODBP-4GB"
    },
    %ProductUpdate{
      url: "https://chicagodist.com/products/raspberry-pi-4-model-b-8gb",
      sku: "RPI4-MODBP-8GB"
    },

    # RPi Zero 2
    %ProductUpdate{url: "https://chicagodist.com/products/raspberry-pi-zero-2", sku: "SC0510"}
  ]

  def all(), do: @items
end
