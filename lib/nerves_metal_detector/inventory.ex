defmodule NervesMetalDetector.Inventory do
  @moduledoc false

  alias NervesMetalDetector.Inventory.Product
  alias NervesMetalDetector.Inventory.ProductAvailability
  alias NervesMetalDetector.Vendors.BerryBaseDe

  @products [
    # Raspberry Pi
    %Product{
      sku: "RPI4-MODBP-1GB",
      name: "RPi 4 Model B - 1GB RAM",
      description: "Raspberry Pi 4 Model b with 1GB Ram",
      type: :sbc
    },
    %Product{
      sku: "RPI4-MODBP-2GB",
      name: "RPi 4 Model B - 2GB RAM",
      description: "Raspberry Pi 4 Model b with 2GB Ram",
      type: :sbc
    },
    %Product{
      sku: "RPI4-MODBP-4GB",
      name: "RPi 4 Model B - 4GB RAM",
      description: "Raspberry Pi 4 Model b with 4GB Ram",
      type: :sbc
    },
    %Product{
      sku: "RPI4-MODBP-8GB",
      name: "RPi 4 Model B - 8GB RAM",
      description: "Raspberry Pi 4 Model b with 8GB Ram",
      type: :sbc
    }
  ]

  @product_update_items [
    %BerryBaseDe.ProductUpdate{
      url: "https://www.berrybase.de/raspberry-pi-4-computer-modell-b-1gb-ram",
      sku: "RPI4-MODBP-1GB"
    },
    %BerryBaseDe.ProductUpdate{
      url: "https://www.berrybase.de/raspberry-pi-4-computer-modell-b-2gb-ram",
      sku: "RPI4-MODBP-2GB"
    },
    %BerryBaseDe.ProductUpdate{
      url: "https://www.berrybase.de/raspberry-pi-4-computer-modell-b-4gb-ram",
      sku: "RPI4-MODBP-4GB"
    },
    %BerryBaseDe.ProductUpdate{
      url: "https://www.berrybase.de/raspberry-pi-4-computer-modell-b-8gb-ram",
      sku: "RPI4-MODBP-8GB"
    }
  ]

  def products(), do: @products

  def product_update_items(), do: @product_update_items

  def fetch_product_availability(args) do
    ProductAvailability.Fetcher.fetch_availability(args)
  end

  def store_product_availability(attrs) do
    ProductAvailability.store(attrs)
  end
end
