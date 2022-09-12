defmodule NervesMetalDetector.Products do
  @moduledoc false

  alias NervesMetalDetector.Product

  @rpi [
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

  @products @rpi

  def all(), do: @products
end
