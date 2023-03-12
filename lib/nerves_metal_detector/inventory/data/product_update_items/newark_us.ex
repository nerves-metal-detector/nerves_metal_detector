defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.NewarkUs do
  alias NervesMetalDetector.Vendors.NewarkUs.ProductUpdate

  @items [
    # RPi CM4
    %ProductUpdate{
      url: "https://www.newark.com/86AH2075",
      sku: "CM4002008"
    },
    %ProductUpdate{
      url: "https://www.newark.com/40AJ6742",
      sku: "CM4004032"
    },
    %ProductUpdate{
      url: "https://www.newark.com/86AH2105",
      sku: "CM4104016"
    },

    # RPi 4
    %ProductUpdate{
      url: "https://www.newark.com/02AH3162",
      sku: "RPI4-MODBP-2GB"
    },
    %ProductUpdate{
      url: "https://www.newark.com/02AH3164",
      sku: "RPI4-MODBP-4GB"
    }
  ]

  def all(), do: @items
end
