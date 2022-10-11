defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.BuyzeroDe do
  alias NervesMetalDetector.Vendors.BuyzeroDe.ProductUpdate

  # IMPORTANT: If a product page features multiple variants,
  # the url needs to contain the variant query param.

  @items [
    # RPi 4
    %ProductUpdate{
      url: "https://buyzero.de/products/raspberry-pi-4b?variant=28034031517798",
      sku: "RPI4-MODBP-2GB"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/raspberry-pi-4b?variant=40326652919988",
      sku: "RPI4-MODBP-4GB"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/raspberry-pi-4-model-b-8gb?variant=31817426698342",
      sku: "RPI4-MODBP-8GB"
    },

    # RPi Zero 2
    %ProductUpdate{
      url: "https://buyzero.de/products/raspberry-pi-zero-2-w?variant=40835211985076",
      sku: "SC0510"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/raspberry-pi-zero-2-w?variant=40835580657844",
      sku: "SC0510WH"
    }
  ]

  def all(), do: @items
end
