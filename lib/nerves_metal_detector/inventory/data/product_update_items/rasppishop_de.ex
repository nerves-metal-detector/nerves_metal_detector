defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.AdafruitUs do
  alias NervesMetalDetector.Vendors.AdafruitUs.ProductUpdate

  @items [
    # RPi 3
    %ProductUpdate{url: "https://www.adafruit.com/product/3775", sku: "RPI3-MODBP"},

    # RPi CM3
    %ProductUpdate{url: "https://www.adafruit.com/product/4093", sku: "CM3+Lite"},
    %ProductUpdate{url: "https://www.adafruit.com/product/4094", sku: "CM3+8GB"},

    # RPi 4
    %ProductUpdate{url: "https://www.adafruit.com/product/4292", sku: "RPI4-MODBP-2GB"},
    %ProductUpdate{url: "https://www.adafruit.com/product/4295", sku: "RPI4-MODBP-1GB"},
    %ProductUpdate{url: "https://www.adafruit.com/product/4296", sku: "RPI4-MODBP-4GB"},
    %ProductUpdate{url: "https://www.adafruit.com/product/4564", sku: "RPI4-MODBP-8GB"},

    # RPi CM4
    %ProductUpdate{url: "https://www.adafruit.com/product/4782", sku: "CM4001000"},
    %ProductUpdate{url: "https://www.adafruit.com/product/4788", sku: "CM4102000"},
    %ProductUpdate{url: "https://www.adafruit.com/product/4790", sku: "CM4102008"},
    %ProductUpdate{url: "https://www.adafruit.com/product/4791", sku: "CM4102016"},
    %ProductUpdate{url: "https://www.adafruit.com/product/4982", sku: "CM4104032"},

    # RPi Zero 2
    %ProductUpdate{url: "https://www.adafruit.com/product/5291", sku: "SC0510"}
  ]

  def all(), do: @items
end
