defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.ElektorNl do
  alias NervesMetalDetector.Vendors.ElektorNl.ProductUpdate

  @items [
    # RPi Zero
    %ProductUpdate{url: "https://www.elektor.nl/raspberry-pi-zero-w", sku: "SC0020"},

    # RPi Zero 2
    %ProductUpdate{url: "https://www.elektor.nl/raspberry-pi-zero-2-w", sku: "SC0510"}
  ]

  def all(), do: @items
end
