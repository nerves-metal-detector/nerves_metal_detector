defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.PiAustraliaAu do
  alias NervesMetalDetector.Vendors.PiAustraliaAu.ProductUpdate

  # IMPORTANT: The url probably needs to contain the variant query param, even for items without other variants.
  # The URL with the variant can be found in the "<script type="application/ld+json">" tag containing
  # the JSON information (under "offers").

  @items [
    # RPi 4
    %ProductUpdate{
      url: "https://raspberry.piaustralia.com.au/products/raspberry-pi-4?variant=32057137954865",
      sku: "RPI4-MODBP-8GB"
    },
    %ProductUpdate{
      url: "https://raspberry.piaustralia.com.au/products/raspberry-pi-4?variant=16389894766641",
      sku: "RPI4-MODBP-4GB"
    },
    %ProductUpdate{
      url: "https://raspberry.piaustralia.com.au/products/raspberry-pi-4?variant=16389894701105",
      sku: "RPI4-MODBP-2GB"
    }
  ]

  def all(), do: @items
end
