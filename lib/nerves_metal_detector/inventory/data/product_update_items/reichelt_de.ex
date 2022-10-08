defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.ReicheltDe do
  alias NervesMetalDetector.Vendors.ReicheltDe.ProductUpdate

  @items [
    # RPi 4
    %ProductUpdate{
      url:
        "https://www.reichelt.de/raspberry-pi-4-b-4x-1-5-ghz-1-gb-ram-wlan-bt-rasp-pi-4-b-1gb-p259874.html",
      sku: "RPI4-MODBP-1GB"
    },
    %ProductUpdate{
      url:
        "https://www.reichelt.de/raspberry-pi-4-b-4x-1-5-ghz-8-gb-ram-wlan-bt-rasp-pi-4-b-8gb-p276923.html",
      sku: "RPI4-MODBP-8GB"
    },
    %ProductUpdate{
      url:
        "https://www.reichelt.de/raspberry-pi-4-b-4x-1-5-ghz-4-gb-ram-wlan-bt-rasp-pi-4-b-4gb-p259920.html",
      sku: "RPI4-MODBP-4GB"
    },

    # RPi CM4
    %ProductUpdate{
      url:
        "https://www.reichelt.de/de/en/raspberry-pi-compute-module-4-1gb-ram-8gb-emmc-wlan-rpi-cm4w-1gb8gb-p290500.html",
      sku: "CM4101008"
    }
  ]

  def all(), do: @items
end
