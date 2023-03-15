defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.ThreeThreeZeroOhmsMx do
  alias NervesMetalDetector.Vendors.ThreeThreeZeroOhmsMx.ProductUpdate

  @items [
    # RPi 4
    %ProductUpdate{
      url: "https://www.330ohms.com/products/raspberry-pi-4-modelo-b-1gb",
      sku: "RPI4-MODBP-1GB"
    },
    %ProductUpdate{
      url: "https://www.330ohms.com/products/raspberry-pi-4-modelo-b-2gb",
      sku: "RPI4-MODBP-2GB"
    },
    %ProductUpdate{
      url: "https://www.330ohms.com/products/raspberry-pi-4-modelo-b-4gb",
      sku: "RPI4-MODBP-4GB"
    },
    %ProductUpdate{
      url: "https://www.330ohms.com/products/raspberry-pi-4-modelo-b-8gb",
      sku: "RPI4-MODBP-8GB"
    },

    # RPi Zero 2
    %ProductUpdate{
      url: "https://www.330ohms.com/products/raspberry-pi-zero-2-w-con-headers",
      sku: "SC0510WH"
    },
    %ProductUpdate{
      url: "https://www.330ohms.com/products/raspberry-pi-zero-2-w",
      sku: "SC0510"
    }
  ]

  def all(), do: @items
end
