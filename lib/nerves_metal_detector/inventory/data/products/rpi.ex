defmodule NervesMetalDetector.Inventory.Data.Products.Rpi do
  alias NervesMetalDetector.Inventory.Product

  @rpi_3 [
    %Product{
      sku: "RPI3-MODAP",
      name: "RPi 3 Model A+ - 512MB RAM",
      description: "Raspberry Pi 3 Model A+ with 512MB RAM",
      type: :sbc
    },
    %Product{
      sku: "RPI3-MODBP",
      name: "RPi 3 Model B+ - 1GB RAM",
      description: "Raspberry Pi 3 Model B+ with 1GB RAM",
      type: :sbc
    }
  ]

  @rpi_4 [
    %Product{
      sku: "RPI4-MODBP-1GB",
      name: "RPi 4 Model B - 1GB RAM",
      description: "Raspberry Pi 4 Model B with 1GB RAM",
      type: :sbc
    },
    %Product{
      sku: "RPI4-MODBP-2GB",
      name: "RPi 4 Model B - 2GB RAM",
      description: "Raspberry Pi 4 Model B with 2GB RAM",
      type: :sbc
    },
    %Product{
      sku: "RPI4-MODBP-4GB",
      name: "RPi 4 Model B - 4GB RAM",
      description: "Raspberry Pi 4 Model B with 4GB RAM",
      type: :sbc
    },
    %Product{
      sku: "RPI4-MODBP-8GB",
      name: "RPi 4 Model B - 8GB RAM",
      description: "Raspberry Pi 4 Model B with 8GB RAM",
      type: :sbc
    }
  ]

  @rpi_cm3 [
    %Product{
      sku: "CM3+Lite",
      name: "RPi CM3+ - 1GB RAM, No MMC",
      description: "Raspberry Pi Compute Module 3 with 1GB RAM and no MMC",
      type: :sbc,
      tags: [:compute_module]
    },
    %Product{
      sku: "CM3+8GB",
      name: "RPi CM3+ - 1GB RAM, 8GB MMC",
      description: "Raspberry Pi Compute Module 3 with 1GB RAM and 8GB MMC",
      type: :sbc,
      tags: [:compute_module]
    },
    %Product{
      sku: "CM3+16GB",
      name: "RPi CM3+ - 1GB RAM, 16GB MMC",
      description: "Raspberry Pi Compute Module 3 with 1GB RAM and 16GB MMC",
      type: :sbc,
      tags: [:compute_module]
    },
    %Product{
      sku: "CM3+32GB",
      name: "RPi CM3+ - 1GB RAM, 32GB MMC",
      description: "Raspberry Pi Compute Module 3 with 1GB RAM and 32GB MMC",
      type: :sbc,
      tags: [:compute_module]
    }
  ]

  @cm4_wifi_name %{"0" => "No Wifi", "1" => "With Wifi"}
  @cm4_wifi_description %{"0" => "no wifi", "1" => "with wifi"}
  @cm4_ram %{"01" => "1GB RAM", "02" => "2GB RAM", "04" => "4GB RAM", "08" => "8GB RAM"}
  @cm4_mmc_name %{"000" => "No MMC", "008" => "8GB MMC", "016" => "16GB MMC", "032" => "32GB MMC"}
  @cm4_mmc_description %{
    "000" => "no MMC",
    "008" => "8GB MMC",
    "016" => "16GB MMC",
    "032" => "32GB MMC"
  }
  @rpi_cm4 (for w <- ["0", "1"],
                r <- ["01", "02", "04", "08"],
                m <- ["000", "008", "016", "032"] do
              %{
                sku: "CM4#{w}#{r}#{m}",
                name: "RPi CM4 - #{@cm4_ram[r]}, #{@cm4_mmc_name[m]}, #{@cm4_wifi_name[w]}",
                description:
                  "Raspberry Pi Compute Module 4 with #{@cm4_ram[r]}, #{@cm4_mmc_description[m]} and #{@cm4_wifi_description[w]}",
                type: :sbc,
                tags: [:compute_module]
              }
            end)

  @rpi0_2 [
    %Product{
      sku: "SC0510",
      name: "RPi Zero 2 W",
      description: "Raspberry Pi Zero 2 with wifi and no headers",
      type: :sbc
    },
    %Product{
      sku: "SC0510WH",
      name: "RPi Zero 2 WH",
      description: "Raspberry Pi Zero 2 with wifi and headers",
      type: :sbc
    }
  ]

  @items @rpi_3 ++ @rpi_4 ++ @rpi_cm3 ++ @rpi_cm4 ++ @rpi0_2

  def all(), do: @items
end
