defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems do
  alias NervesMetalDetector.Inventory.Data.ProductUpdateItems

  @collections [
    ProductUpdateItems.AdafruitUs,
    ProductUpdateItems.BerryBaseDe,
    ProductUpdateItems.BuyzeroDe,
    ProductUpdateItems.ChicagoElectronicDistributorsUs,
    ProductUpdateItems.ElektorNl,
    ProductUpdateItems.KubiiFr,
    ProductUpdateItems.McHobbyBe,
    ProductUpdateItems.MeloperoIt,
    ProductUpdateItems.PimoroniUk,
    ProductUpdateItems.PiShopCa,
    ProductUpdateItems.PiShopCh,
    ProductUpdateItems.PiShopUs,
    ProductUpdateItems.RaspberryStoreNl,
    ProductUpdateItems.RasppishopDe,
    ProductUpdateItems.ReicheltDe,
    ProductUpdateItems.SeeedStudioCn,
    ProductUpdateItems.SemafAt,
    ProductUpdateItems.SparkfunUs,
    ProductUpdateItems.ThePiHutUk,
    ProductUpdateItems.TiendatecEs,
    ProductUpdateItems.WelectronDe
  ]

  @items @collections |> Enum.map(& &1.all()) |> List.flatten()

  def all(), do: @items
end
