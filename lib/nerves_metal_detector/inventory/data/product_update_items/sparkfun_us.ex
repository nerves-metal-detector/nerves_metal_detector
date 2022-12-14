defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.SparkfunUs do
  alias NervesMetalDetector.Vendors.SparkfunUs.ProductUpdate

  @items [
    # Rpi 3 
    %ProductUpdate{sku: "RPI3-MODBP", url: "https://www.sparkfun.com/products/14643"},

    # Rpi 4
    %ProductUpdate{sku: "RPI4-MODBP-4GB", url: "https://www.sparkfun.com/products/15447"},
    %ProductUpdate{sku: "RPI4-MODBP-8GB", url: "https://www.sparkfun.com/products/16811"},
    %ProductUpdate{sku: "RPI4-MODBP-2GB", url: "https://www.sparkfun.com/products/15446"},

    # Rpi CM4
    %ProductUpdate{sku: "CM4102008", url: "https://www.sparkfun.com/products/17391"},
    %ProductUpdate{sku: "CM4001000", url: "https://www.sparkfun.com/products/17364"},
    %ProductUpdate{sku: "CM4002008", url: "https://www.sparkfun.com/products/17284"},
    %ProductUpdate{sku: "CM4002016", url: "https://www.sparkfun.com/products/17390"},
    %ProductUpdate{sku: "CM4102000", url: "https://www.sparkfun.com/products/17384"},
    %ProductUpdate{sku: "CM4102032", url: "https://www.sparkfun.com/products/18351"},
    %ProductUpdate{sku: "CM4104032", url: "https://www.sparkfun.com/products/17392"},

    # RPi Zero 2
    %ProductUpdate{sku: "SC0510", url: "https://www.sparkfun.com/products/18713"}
  ]

  def all(), do: @items
end
