defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.WelectronDe do
  alias NervesMetalDetector.Vendors.WelectronDe.ProductUpdate

  @items [
    # RPi CM4
    %ProductUpdate{
      url: "https://www.welectron.com/Raspberry-Pi-CM4002008-Compute-Module-8-GB-2-GB-RAM",
      sku: "CM4002008"
    },
    %ProductUpdate{
      url: "https://www.welectron.com/Raspberry-Pi-CM4002000-Compute-Module-Lite-2-GB-RAM",
      sku: "CM4002000"
    },
    %ProductUpdate{
      url:
        "https://www.welectron.com/Raspberry-Pi-CM4104016-Compute-Module-16-GB-4-GB-RAM-WLAN_1",
      sku: "CM4104016"
    },
    %ProductUpdate{
      url: "https://www.welectron.com/Raspberry-Pi-CM4108000-Compute-Module-Lite-8-GB-RAM-WLAN",
      sku: "CM4108000"
    },
    %ProductUpdate{
      url: "https://www.welectron.com/Raspberry-Pi-CM4001000-Compute-Module-Lite-1-GB-RAM_1",
      sku: "CM4001000"
    },
    %ProductUpdate{
      url: "https://www.welectron.com/Raspberry-Pi-CM4101016-Compute-Module-16-GB-1-GB-RAM-WLAN",
      sku: "CM4101016"
    },
    %ProductUpdate{
      url: "https://www.welectron.com/Raspberry-Pi-CM4104000-Compute-Module-Lite-4-GB-RAM-WLAN",
      sku: "CM4104000"
    },
    %ProductUpdate{
      url: "https://www.welectron.com/Raspberry-Pi-CM4001008-Compute-Module-8-GB-1-GB-RAM",
      sku: "CM4001008"
    },
    %ProductUpdate{
      url: "https://www.welectron.com/Raspberry-Pi-CM4001016-Compute-Module-16-GB-1-GB-RAM",
      sku: "CM4001016"
    },
    %ProductUpdate{
      url: "https://www.welectron.com/Raspberry-Pi-CM4001032-Compute-Module-32-GB-1-GB-RAM",
      sku: "CM4001032"
    },
    %ProductUpdate{
      url: "https://www.welectron.com/Raspberry-Pi-CM4102008-Compute-Module-8-GB-2-GB-RAM-WLAN",
      sku: "CM4102008"
    },
    %ProductUpdate{
      url: "https://www.welectron.com/Raspberry-Pi-CM4108016-Compute-Module-16-GB-8-GB-RAM-WLAN",
      sku: "CM4108016"
    },
    %ProductUpdate{
      url: "https://www.welectron.com/Raspberry-Pi-CM4108032-Compute-Module-32-GB-8-GB-RAM-WLAN",
      sku: "CM4108032"
    },

    # RPi 4
    %ProductUpdate{url: "https://www.welectron.com/Raspberry-Pi-4-B-2-GB", sku: "RPI4-MODBP-2GB"},
    %ProductUpdate{url: "https://www.welectron.com/Raspberry-Pi-4-B-4-GB", sku: "RPI4-MODBP-4GB"},
    %ProductUpdate{
      url: "https://www.welectron.com/Raspberry-Pi-4-8-GB-Board",
      sku: "RPI4-MODBP-8GB"
    },
    %ProductUpdate{url: "https://www.welectron.com/Raspberry-Pi-4-B-1-GB", sku: "RPI4-MODBP-1GB"},

    # RPi Zero 2
    %ProductUpdate{url: "https://www.welectron.com/Raspberry-Pi-Zero-2-W", sku: "SC0510"}
  ]

  def all(), do: @items
end
