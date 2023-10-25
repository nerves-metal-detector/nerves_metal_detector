defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.RaspberryPiDk do
  alias NervesMetalDetector.Vendors.RaspberryPiDk.ProductUpdate

  @items [
    # RPi CM3
    # These urls cannot be properly scraped because the metadata on the shop
    # does not have info for each individual configuration
    #    %ProductUpdate{
    #      url: "https://raspberrypi.dk/en/product/raspberry-pi-compute-module-3-plus/?attribute_pa_pi-cm3-plus-udgave=compute-module-3-lite",
    #      sku: "CM3+Lite"
    #    },
    #    %ProductUpdate{
    #      url: "https://raspberrypi.dk/en/product/raspberry-pi-compute-module-3-plus/?attribute_pa_pi-cm3-plus-udgave=compute-module-3-8gb",
    #      sku: "CM3+8GB"
    #    },
    #    %ProductUpdate{
    #      url: "https://raspberrypi.dk/en/product/raspberry-pi-compute-module-3-plus/?attribute_pa_pi-cm3-plus-udgave=compute-module-3-16gb",
    #      sku: "CM3+16GB"
    #    },
    #    %ProductUpdate{
    #      url: "https://raspberrypi.dk/en/product/raspberry-pi-compute-module-3-plus/?attribute_pa_pi-cm3-plus-udgave=compute-module-3-32gb",
    #      sku: "CM3+32GB"
    #    },

    # RPi CM4
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4001000-sc0695/",
      sku: "CM4001000"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4001008-sc0696/",
      sku: "CM4001008"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4001016-sc0697/",
      sku: "CM4001016"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4001032-sc0698/",
      sku: "CM4001032"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4002000-sc0679/",
      sku: "CM4002000"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4002008-sc0680/",
      sku: "CM4002008"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4002016-sc0681/",
      sku: "CM4002016"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4002032-sc0682/",
      sku: "CM4002032"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4008032-sc0690/",
      sku: "CM4008032"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4004000-sc0683/",
      sku: "CM4004000"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4101000-sc0691/",
      sku: "CM4101000"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4004008-sc0684/",
      sku: "CM4004008"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4101008-sc0692/",
      sku: "CM4101008"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4004016-sc0685/",
      sku: "CM4004016"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4101016-sc0693/",
      sku: "CM4101016"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4004032-sc0686/",
      sku: "CM4004032"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4101032-sc0694/",
      sku: "CM4101032"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4008000-sc0687/",
      sku: "CM4008000"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4102000-sc0667/",
      sku: "CM4102000"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4008008-sc0688/",
      sku: "CM4008008"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4102008-sc0668/",
      sku: "CM4102008"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4008016-sc0689/",
      sku: "CM4008016"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4102016-sc0669/",
      sku: "CM4102016"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4102032-sc0670/",
      sku: "CM4102032"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4104000-sc0671/",
      sku: "CM4104000"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4104008-sc0672/",
      sku: "CM4104008"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4104016-sc0673/",
      sku: "CM4104016"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4104032-sc0674/",
      sku: "CM4104032"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4108000-sc0675/",
      sku: "CM4108000"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4108008-sc0676/",
      sku: "CM4108008"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4108016-sc0677/",
      sku: "CM4108016"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/en/product/cm4108032-sc0678/",
      sku: "CM4108032"
    },

    # RPi 3
    %ProductUpdate{
      url: "https://raspberrypi.dk/produkt/raspberry-pi-3-model-a-plus/",
      sku: "RPI3-MODAP"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/produkt/raspberry-pi-3-model-b-plus/",
      sku: "RPI3-MODBP"
    },

    # RPi 4
    %ProductUpdate{
      url: "https://raspberrypi.dk/produkt/raspberry-pi-4-model-b-1-gb/",
      sku: "RPI4-MODBP-1GB"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/produkt/raspberry-pi-4-model-b-2-gb/",
      sku: "RPI4-MODBP-2GB"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/produkt/raspberry-pi-4-model-b-4-gb/",
      sku: "RPI4-MODBP-4GB"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/produkt/raspberry-pi-4-model-b-8-gb/",
      sku: "RPI4-MODBP-8GB"
    },

    # RPi Zero
    %ProductUpdate{
      url: "https://raspberrypi.dk/produkt/raspberry-pi-zero-w/",
      sku: "SC0020"
    },
    %ProductUpdate{
      url: "https://raspberrypi.dk/produkt/raspberry-pi-zero-wh-paaloddet-header/",
      sku: "SC0020WH"
    },

    # RPi Zero 2
    %ProductUpdate{
      url: "https://raspberrypi.dk/produkt/raspberry-pi-zero-2-w/",
      sku: "SC0510"
    }
  ]

  def all(), do: @items
end
