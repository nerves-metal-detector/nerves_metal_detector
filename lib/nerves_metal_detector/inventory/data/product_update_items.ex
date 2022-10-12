defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems do
  alias NervesMetalDetector.Inventory.Data.ProductUpdateItems

  @collections [
    ProductUpdateItems.AdafruitUs,
    ProductUpdateItems.BerryBaseDe,
    ProductUpdateItems.BuyzeroDe,
    ProductUpdateItems.KubiiFr,
    ProductUpdateItems.McHobbyBe,
    ProductUpdateItems.MeloperoIt,
    ProductUpdateItems.PimoroniUk,
    ProductUpdateItems.PiShopCa,
    ProductUpdateItems.PiShopCh,
    ProductUpdateItems.PiShopUs,
    ProductUpdateItems.RasppishopDe,
    ProductUpdateItems.ReicheltDe,
    ProductUpdateItems.SeeedStudioCn,
    ProductUpdateItems.SemafAt,
    ProductUpdateItems.TiendatecEs,
    ProductUpdateItems.WelectronDe,
    ProductUpdateItems.SparkfunUs
  ]

  @items @collections |> Enum.map(& &1.all()) |> List.flatten()

  def all(), do: @items
end
