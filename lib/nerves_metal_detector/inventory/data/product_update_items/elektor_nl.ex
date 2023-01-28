defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.ElektorNl do
  alias NervesMetalDetector.Vendors.ElektorNl.ProductUpdate

  @items [
    # RPi Zero 2
    %ProductUpdate{
      url:
        "https://www.elektor.nl/raspberry-pi-zero-2-wh-with-pre-soldered-40-pin-color-coded-gpio-header",
      sku: "SC0510WH"
    },
    %ProductUpdate{url: "https://www.elektor.nl/raspberry-pi-zero-2-w", sku: "SC0510"}
  ]

  def all(), do: @items
end
