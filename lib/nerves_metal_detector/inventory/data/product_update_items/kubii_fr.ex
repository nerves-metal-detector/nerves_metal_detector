defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.KubiiFr do
  alias NervesMetalDetector.Vendors.KubiiFr.ProductUpdate

  @items [
    # RPi 4
    %ProductUpdate{
      url:
        "https://www.kubii.fr/cartes-raspberry-pi/2771-nouveau-raspberry-pi-4-modele-b-2gb-0765756931175.html",
      sku: "RPI4-MODBP-2GB"
    },
    %ProductUpdate{
      url:
        "https://www.kubii.fr/cartes-raspberry-pi/2772-nouveau-raspberry-pi-4-modele-b-4gb-kubii-0765756931182.html",
      sku: "RPI4-MODBP-4GB"
    },
    %ProductUpdate{
      url:
        "https://www.kubii.fr/cartes-raspberry-pi/2955-raspberry-pi-4-modele-b-8gb-0765756931199.html",
      sku: "RPI4-MODBP-8GB"
    },

    # RPi Zero 2
    %ProductUpdate{
      url:
        "https://www.kubii.fr/cartes-raspberry-pi/3455-raspberry-pi-zero-2-w-5056561800004.html",
      sku: "SC0510"
    }
  ]

  def all(), do: @items
end
