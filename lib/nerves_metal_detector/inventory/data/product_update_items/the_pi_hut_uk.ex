defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.ThePiHutUk do
  alias NervesMetalDetector.Vendors.ThePiHutUk.ProductUpdate

  @items [
    # RPi 3
    %ProductUpdate{
      sku: "RPI3-MODAP",
      url: "https://thepihut.com/products/raspberry-pi-3-model-a-plus?variant=13584708763710"
    },
    %ProductUpdate{
      sku: "RPI3-MODBP",
      url: "https://thepihut.com/products/raspberry-pi-3-model-b-plus?variant=18157318733886"
    },

    # RPi 4
    %ProductUpdate{
      sku: "RPI4-MODBP-2GB",
      url: "https://thepihut.com/products/raspberry-pi-4-model-b?variant=20064052674622"
    },
    %ProductUpdate{
      sku: "RPI4-MODBP-4GB",
      url: "https://thepihut.com/products/raspberry-pi-4-model-b?variant=20064052740158"
    },
    %ProductUpdate{
      sku: "RPI4-MODBP-8GB",
      url: "https://thepihut.com/products/raspberry-pi-4-model-b?variant=31994565689406"
    },
    %ProductUpdate{
      sku: "RPI4-MODBP-1GB",
      url: "https://thepihut.com/products/raspberry-pi-4-model-b?variant=41005997392067"
    },

    # RPi CM4
    %ProductUpdate{
      sku: "CM4101000",
      url: "https://thepihut.com/products/raspberry-pi-compute-module-4?variant=39486529536195"
    },
    %ProductUpdate{
      sku: "CM4102000",
      url: "https://thepihut.com/products/raspberry-pi-compute-module-4?variant=39486529601731"
    },
    %ProductUpdate{
      sku: "CM4002000",
      url: "https://thepihut.com/products/raspberry-pi-compute-module-4?variant=39486529634499"
    },
    %ProductUpdate{
      sku: "CM4104000",
      url: "https://thepihut.com/products/raspberry-pi-compute-module-4?variant=39486529667267"
    },
    %ProductUpdate{
      sku: "CM4004000",
      url: "https://thepihut.com/products/raspberry-pi-compute-module-4?variant=39486529700035"
    },
    %ProductUpdate{
      sku: "CM4008000",
      url: "https://thepihut.com/products/raspberry-pi-compute-module-4?variant=39486529765571"
    },
    %ProductUpdate{
      sku: "CM4102008",
      url: "https://thepihut.com/products/raspberry-pi-compute-module-4?variant=39486529863875"
    },
    %ProductUpdate{
      sku: "CM4002008",
      url: "https://thepihut.com/products/raspberry-pi-compute-module-4?variant=39486529896643"
    },
    %ProductUpdate{
      sku: "CM4102016",
      url: "https://thepihut.com/products/raspberry-pi-compute-module-4?variant=39486530126019"
    },
    %ProductUpdate{
      sku: "CM4002016",
      url: "https://thepihut.com/products/raspberry-pi-compute-module-4?variant=39486530158787"
    },
    %ProductUpdate{
      sku: "CM4002032",
      url: "https://thepihut.com/products/raspberry-pi-compute-module-4?variant=39486530420931"
    },
    %ProductUpdate{
      sku: "CM4004032",
      url: "https://thepihut.com/products/raspberry-pi-compute-module-4?variant=39486530486467"
    },
    %ProductUpdate{
      sku: "CM4108032",
      url: "https://thepihut.com/products/raspberry-pi-compute-module-4?variant=39486530519235"
    },
    %ProductUpdate{
      sku: "CM4008032",
      url: "https://thepihut.com/products/raspberry-pi-compute-module-4?variant=39486530552003"
    },

    # RPi Zero
    %ProductUpdate{
      url: "https://thepihut.com/products/raspberry-pi-zero-w?variant=31901049749566",
      sku: "SC0020"
    },
    %ProductUpdate{
      url:
        "https://thepihut.com/products/raspberry-pi-zero-wh-with-pre-soldered-header?variant=547332849681",
      sku: "SC0020WH"
    },

    # RPi Zero 2
    %ProductUpdate{
      sku: "SC0510",
      url: "https://thepihut.com/products/raspberry-pi-zero-2?variant=41181426909379"
    },
    %ProductUpdate{
      sku: "SC0510WH",
      url: "https://thepihut.com/products/raspberry-pi-zero-2?variant=41181426942147"
    }
  ]

  def all(), do: @items
end
