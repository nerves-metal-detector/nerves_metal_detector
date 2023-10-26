defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.ReicheltDe do
  alias NervesMetalDetector.Vendors.ReicheltDe.ProductUpdate

  @items [
    # RPi CM4
    %ProductUpdate{
      url:
        "https://www.reichelt.de/raspberry-pi-compute-module-4-1gb-ram-16gb-emmc-wlan-rpi-cm4w-1gb16gb-p290501.html",
      sku: "CM4101016"
    },
    %ProductUpdate{
      url:
        "https://www.reichelt.de/raspberry-pi-compute-module-4-1gb-ram-32gb-emmc-rpi-cm4-1gb32gb-p290498.html",
      sku: "CM4001032"
    },
    %ProductUpdate{
      url:
        "https://www.reichelt.de/raspberry-pi-compute-module-4-1gb-ram-8gb-emmc-rpi-cm4-1gb8gb-p290496.html?&trstct=pol_11&nbc=1",
      sku: "CM4001008"
    },
    %ProductUpdate{
      url:
        "https://www.reichelt.de/raspberry-pi-compute-module-4-4gb-ram-8gb-emmc-wlan-rpi-cm4w-4gb8gb-p290540.html",
      sku: "CM4104008"
    },

    # RPi 3
    %ProductUpdate{
      url:
        "https://www.reichelt.de/raspberry-pi-3-a-4x-1-4-ghz-512-mb-ram-wlan-bt-raspberry-pi-3a--p243791.html",
      sku: "RPI3-MODAP"
    },

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
    },
    %ProductUpdate{
      url:
        "https://www.reichelt.de/de/en/raspberry-pi-compute-module-4-1-gb-ram-32-gb-emmc-wi-fi-rpi-cm4w-1gb32gb-p290502.html",
      sku: "CM4101032"
    },
    %ProductUpdate{
      url:
        "https://www.reichelt.de/de/en/raspberry-pi-compute-module-4-2gb-ram-16gb-emmc-rpi-cm4-2gb16gb-p290528.html",
      sku: "CM4002016"
    },
    %ProductUpdate{
      url:
        "https://www.reichelt.de/de/en/raspberry-pi-compute-module-4-8gb-ram-8gb-emmc-rpi-cm4-8gb8gb-p290545.html",
      sku: "CM4008008"
    },

    # RPi Zero
    %ProductUpdate{
      url:
        "https://www.reichelt.de/de/en/raspberry-pi-zero-w-v-1-1-1-ghz-512-mb-ram-wi-fi-bt-rasp-pi-zero-w-p256438.html",
      sku: "SC0020"
    }
  ]

  def all(), do: @items
end
