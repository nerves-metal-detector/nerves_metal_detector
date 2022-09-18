defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems do
  @vendors [
    NervesMetalDetector.Inventory.Data.ProductUpdateItems.BerryBaseDe
  ]

  @items @vendors |> Enum.map(& &1.all()) |> List.flatten()

  def all(), do: @items
end
