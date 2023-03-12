defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.FarnellUk do
  alias NervesMetalDetector.Vendors.FarnellUk.ProductUpdate

  @items [
    # RPi CM4
    %ProductUpdate{
      url: "https://uk.farnell.com/3563478",
      sku: "CM4002008"
    },
    %ProductUpdate{
      url: "https://uk.farnell.com/3678904",
      sku: "CM4004032"
    },
    %ProductUpdate{
      url: "https://uk.farnell.com/3563484",
      sku: "CM4102008"
    },
    %ProductUpdate{
      url: "https://uk.farnell.com/3563486",
      sku: "CM4102032"
    },
    %ProductUpdate{
      url: "https://uk.farnell.com/3563487",
      sku: "CM4104000"
    },
    %ProductUpdate{
      url: "https://uk.farnell.com/3563489",
      sku: "CM4104016"
    },
    %ProductUpdate{
      url: "https://uk.farnell.com/3563490",
      sku: "CM4104032"
    },
    %ProductUpdate{
      url: "https://uk.farnell.com/3678912",
      sku: "CM4108008"
    },

    # RPi 4
    %ProductUpdate{
      url: "https://uk.farnell.com/3051886",
      sku: "RPI4-MODBP-2GB"
    },
    %ProductUpdate{
      url: "https://uk.farnell.com/3051887",
      sku: "RPI4-MODBP-4GB"
    },
    %ProductUpdate{
      url: "https://uk.farnell.com/3369503",
      sku: "RPI4-MODBP-8GB"
    },

    # RPi Zero 2
    %ProductUpdate{
      url: "https://uk.farnell.com/3838499",
      sku: "SC0510"
    }
  ]

  def all(), do: @items
end
