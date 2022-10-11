defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.TiendatecEs do
  alias NervesMetalDetector.Vendors.TiendatecEs.ProductUpdate

  @items [
    # RPi 4
    %ProductUpdate{
      url:
        "https://www.tiendatec.es/raspberry-pi/gama-raspberry-pi/1098-raspberry-pi-4-modelo-b-1gb-765756931168.html",
      sku: "RPI4-MODBP-1GB"
    },
    %ProductUpdate{
      url:
        "https://www.tiendatec.es/raspberry-pi/gama-raspberry-pi/1231-raspberry-pi-4-modelo-b-8gb-765756931199.html",
      sku: "RPI4-MODBP-8GB"
    },
    %ProductUpdate{
      url:
        "https://www.tiendatec.es/raspberry-pi/gama-raspberry-pi/1099-raspberry-pi-4-modelo-b-2gb-765756931175.html",
      sku: "RPI4-MODBP-2GB"
    },
    %ProductUpdate{
      url:
        "https://www.tiendatec.es/raspberry-pi/gama-raspberry-pi/1100-raspberry-pi-4-modelo-b-4gb-765756931182.html",
      sku: "RPI4-MODBP-4GB"
    },

    # RPi 3
    %ProductUpdate{
      url:
        "https://www.tiendatec.es/raspberry-pi/gama-raspberry-pi/89-raspberry-pi-1-modelo-a-512mb-nuevo-modelo-640522711086.html",
      sku: "RPI3-MODAP"
    },
    %ProductUpdate{
      url:
        "https://www.tiendatec.es/raspberry-pi/gama-raspberry-pi/752-raspberry-pi-3-modelo-b-plus-5060214370165.html",
      sku: "RPI3-MODBP"
    },

    # RPi Zero 2
    %ProductUpdate{
      url:
        "https://www.tiendatec.es/raspberry-pi/gama-raspberry-pi/1735-raspberry-pi-zero-2-w-5056561800004.html",
      sku: "SC0510"
    }
  ]

  def all(), do: @items
end
