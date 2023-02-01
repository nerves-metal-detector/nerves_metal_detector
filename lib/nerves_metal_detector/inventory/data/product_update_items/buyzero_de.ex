defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.BuyzeroDe do
  alias NervesMetalDetector.Vendors.BuyzeroDe.ProductUpdate

  # IMPORTANT: If a product page features multiple variants,
  # the url needs to contain the variant query param.

  @items [
    # RPi 3
    %ProductUpdate{
      url: "https://buyzero.de/products/raspberry-pi-3-a-plus?variant=15410464129126",
      sku: "RPI3-MODAP"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/raspberry-pi-3b-plus?variant=6471085359131",
      sku: "RPI3-MODBP"
    },

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

    # RPi CM4
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358644838",
      sku: "CM4001000"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358677606",
      sku: "CM4001008"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358710374",
      sku: "CM4001016"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358743142",
      sku: "CM4001032"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358775910",
      sku: "CM4002000"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358808678",
      sku: "CM4002008"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358841446",
      sku: "CM4002016"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358874214",
      sku: "CM4002032"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358906982",
      sku: "CM4004000"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358939750",
      sku: "CM4004008"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358972518",
      sku: "CM4004016"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090359005286",
      sku: "CM4004032"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090359038054",
      sku: "CM4008000"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090359070822",
      sku: "CM4008008"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090359103590",
      sku: "CM4008016"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090359136358",
      sku: "CM4008032"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358120550",
      sku: "CM4101000"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358153318",
      sku: "CM4101008"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358186086",
      sku: "CM4101016"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358218854",
      sku: "CM4101032"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358251622",
      sku: "CM4102000"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358284390",
      sku: "CM4102008"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358317158",
      sku: "CM4102016"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358349926",
      sku: "CM4102032"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358382694",
      sku: "CM4104000"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358415462",
      sku: "CM4104008"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358448230",
      sku: "CM4104016"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358480998",
      sku: "CM4104032"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358513766",
      sku: "CM4108000"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358546534",
      sku: "CM4108008"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358579302",
      sku: "CM4108016"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/compute-module-4-cm4?variant=32090358612070",
      sku: "CM4108032"
    },

    # RPi Zero
    %ProductUpdate{
      url: "https://buyzero.de/products/raspberry-pi-zero-w?variant=38399156114",
      sku: "SC0020"
    },
    %ProductUpdate{
      url: "https://buyzero.de/products/raspberry-pi-zero-w?variant=32929081170",
      sku: "SC0020WH"
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
