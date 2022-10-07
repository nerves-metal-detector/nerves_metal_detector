defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems do
  alias NervesMetalDetector.Inventory.Data.ProductUpdateItems

  @collections [
    ProductUpdateItems.AdafruitUs,
    ProductUpdateItems.BerryBaseDe,
    ProductUpdateItems.McHobbyBe,
    ProductUpdateItems.PimoroniUk,
    ProductUpdateItems.PiShopCa,
    ProductUpdateItems.PiShopCh,
    ProductUpdateItems.PiShopUs,
    ProductUpdateItems.SemafAt
  ]

  @items @collections |> Enum.map(& &1.all()) |> List.flatten()

  def all(), do: @items
end
