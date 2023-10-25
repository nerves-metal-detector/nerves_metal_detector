defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.KamamiPl do
  alias NervesMetalDetector.Vendors.KamamiPl.ProductUpdate

  @items [
    # RPi 3
    %ProductUpdate{
      url:
        "https://kamami.pl/raspberry-pi-3-model-a/573175-raspberry-pi-3-model-a-z-wifi-24-i-5-ghz-oraz-bluetooth-42.html",
      sku: "RPI3-MODAP"
    },
    %ProductUpdate{
      url:
        "https://kamami.pl/raspberry-pi-3-model-b/569726-raspberry-pi-3-model-b-plus-z-wifi-24-i-5ghz-oraz-bluetooth-42.html",
      sku: "RPI3-MODBP"
    },

    # RPi 4
    %ProductUpdate{
      url:
        "https://kamami.pl/raspberry-pi-4-model-b/575559-raspberry-pi-4-model-b-z-1gb-ram-dual-band-wifi-bluetooth-50-15ghz.html",
      sku: "RPI4-MODBP-1GB"
    },
    %ProductUpdate{
      url:
        "https://kamami.pl/raspberry-pi-4-model-b/575567-raspberry-pi-4-model-b-z-2gb-ram-dual-band-wifi-bluetooth-50-15ghz.html",
      sku: "RPI4-MODBP-2GB"
    },
    %ProductUpdate{
      url:
        "https://kamami.pl/raspberry-pi-4-model-b/575568-raspberry-pi-4-model-b-z-4gb-ram-dual-band-wifi-bluetooth-50-15ghz.html",
      sku: "RPI4-MODBP-4GB"
    },
    %ProductUpdate{
      url:
        "https://kamami.pl/raspberry-pi-4-model-b/579161-raspberry-pi-4-model-b-z-8gb-ram-dual-band-wifi-bluetooth-50-15ghz.html",
      sku: "RPI4-MODBP-8GB"
    },

    # RPi Zero
    %ProductUpdate{
      url:
        "https://kamami.pl/raspberry-pi-zero/1183083-sc0020-raspberry-pi-zero-w--707565827164.html",
      sku: "SC0020"
    },

    # RPi Zero 2
    %ProductUpdate{
      url:
        "https://kamami.pl/raspberry-pi-zero-2-w/587851-raspberry-pi-zero-2-w-z-512mb-ram-4x1ghz-wifi-bluetooth.html",
      sku: "SC0510"
    }
  ]

  def all(), do: @items
end
