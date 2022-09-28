defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems do
  alias NervesMetalDetector.Inventory.Data.ProductUpdateItems

  @collections [
    ProductUpdateItems.AdafruitUs,
    ProductUpdateItems.BerryBaseDe,
    ProductUpdateItems.PimoroniUk
  ]

  @items @collections |> Enum.map(& &1.all()) |> List.flatten()

  def all(), do: @items
end
