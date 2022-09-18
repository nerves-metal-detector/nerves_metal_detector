defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.BerryBaseDe do
  alias NervesMetalDetector.Vendors.BerryBaseDe

  @items [
    %BerryBaseDe.ProductUpdate{
      url: "https://www.berrybase.de/raspberry-pi-4-computer-modell-b-1gb-ram",
      sku: "RPI4-MODBP-1GB"
    },
    %BerryBaseDe.ProductUpdate{
      url: "https://www.berrybase.de/raspberry-pi-4-computer-modell-b-2gb-ram",
      sku: "RPI4-MODBP-2GB"
    },
    %BerryBaseDe.ProductUpdate{
      url: "https://www.berrybase.de/raspberry-pi-4-computer-modell-b-4gb-ram",
      sku: "RPI4-MODBP-4GB"
    },
    %BerryBaseDe.ProductUpdate{
      url: "https://www.berrybase.de/raspberry-pi-4-computer-modell-b-8gb-ram",
      sku: "RPI4-MODBP-8GB"
    }
  ]

  def all(), do: @items
end
