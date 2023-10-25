defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems.SeeedStudioCn do
  alias NervesMetalDetector.Vendors.SeeedStudioCn.ProductUpdate

  @items [
    # RPi CM4
    %ProductUpdate{
      url: "https://www.seeedstudio.com/raspberry-pi-compute-module-cm4001000-p-4720.html",
      sku: "CM4001000"
    },
    %ProductUpdate{
      url: "https://www.seeedstudio.com/raspberry-pi-compute-module-cm4008000-p-5221.html",
      sku: "CM4008000"
    },
    %ProductUpdate{
      url: "https://www.seeedstudio.com/raspberry-pi-compute-module-cm4102000-p-4718.html",
      sku: "CM4102000"
    },
    %ProductUpdate{
      url: "https://www.seeedstudio.com/raspberry-pi-compute-module-cm4102008-p-4719.html",
      sku: "CM4102008"
    },
    %ProductUpdate{
      url: "https://www.seeedstudio.com/raspberry-pi-compute-module-cm4102032-p-4721.html",
      sku: "CM4102032"
    },
    %ProductUpdate{
      url: "https://www.seeedstudio.com/raspberry-pi-compute-module-cm4104016-p-5222.html",
      sku: "CM4104016"
    },
    %ProductUpdate{
      url: "https://www.seeedstudio.com/raspberry-pi-compute-module-cm4104032-p-4722.html",
      sku: "CM4104032"
    },
    %ProductUpdate{
      url: "https://www.seeedstudio.com/raspberry-pi-compute-module-cm4108032-p-5220.html",
      sku: "CM4108032"
    },

    # RPi 4
    %ProductUpdate{
      url: "https://www.seeedstudio.com/Raspberry-Pi-4-Computer-Model-B-4GB-p-4077.html",
      sku: "RPI4-MODBP-4GB"
    }
  ]

  def all(), do: @items
end
