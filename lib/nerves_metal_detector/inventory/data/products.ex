defmodule NervesMetalDetector.Inventory.Data.Products do
  @product_lists [
    NervesMetalDetector.Inventory.Data.Products.Rpi
  ]

  @items @product_lists |> Enum.map(& &1.all()) |> List.flatten()

  def all(), do: @items
end
