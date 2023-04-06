defmodule NervesMetalDetector.Inventory.Data.ProductUpdateItems do
  alias NervesMetalDetector.Vendors
  alias NervesMetalDetector.Inventory.Data.ProductUpdateItems

  @mapping %{
    Vendors.AdafruitUs => ProductUpdateItems.AdafruitUs,
    Vendors.ArgonFortyCn => ProductUpdateItems.ArgonFortyCn,
    Vendors.BerryBaseDe => ProductUpdateItems.BerryBaseDe,
    Vendors.BuyzeroDe => ProductUpdateItems.BuyzeroDe,
    Vendors.BotlandCz => ProductUpdateItems.BotlandCz,
    Vendors.BotlandDe => ProductUpdateItems.BotlandDe,
    Vendors.BotlandEu => ProductUpdateItems.BotlandEu,
    Vendors.BotlandPl => ProductUpdateItems.BotlandPl,
    Vendors.CoolComponentsUk => ProductUpdateItems.CoolComponentsUk,
    Vendors.ChicagoElectronicDistributorsUs => ProductUpdateItems.ChicagoElectronicDistributorsUs,
    Vendors.ElectrokitSe => ProductUpdateItems.ElectrokitSe,
    Vendors.ElektorNl => ProductUpdateItems.ElektorNl,
    Vendors.FarnellUk => ProductUpdateItems.FarnellUk,
    Vendors.KamamiPl => ProductUpdateItems.KamamiPl,
    Vendors.KubiiFr => ProductUpdateItems.KubiiFr,
    Vendors.McHobbyBe => ProductUpdateItems.McHobbyBe,
    Vendors.MeloperoIt => ProductUpdateItems.MeloperoIt,
    Vendors.NewarkUs => ProductUpdateItems.NewarkUs,
    Vendors.PiAustraliaAu => ProductUpdateItems.PiAustraliaAu,
    Vendors.PimoroniUk => ProductUpdateItems.PimoroniUk,
    Vendors.PiShopCa => ProductUpdateItems.PiShopCa,
    Vendors.PiShopCh => ProductUpdateItems.PiShopCh,
    Vendors.PiShopUs => ProductUpdateItems.PiShopUs,
    Vendors.PiShopZa => ProductUpdateItems.PiShopZa,
    Vendors.RapidUk => ProductUpdateItems.RapidUk,
    Vendors.RaspberryPiDk => ProductUpdateItems.RaspberryPiDk,
    Vendors.RaspberryStoreNl => ProductUpdateItems.RaspberryStoreNl,
    Vendors.RasppishopDe => ProductUpdateItems.RasppishopDe,
    Vendors.ReicheltDe => ProductUpdateItems.ReicheltDe,
    Vendors.SeeedStudioCn => ProductUpdateItems.SeeedStudioCn,
    Vendors.SemafAt => ProductUpdateItems.SemafAt,
    Vendors.SparkfunUs => ProductUpdateItems.SparkfunUs,
    Vendors.ThePiHutUk => ProductUpdateItems.ThePiHutUk,
    Vendors.ThreeThreeZeroOhmsMx => ProductUpdateItems.ThreeThreeZeroOhmsMx,
    Vendors.TiendatecEs => ProductUpdateItems.TiendatecEs,
    Vendors.WelectronDe => ProductUpdateItems.WelectronDe
  }

  def all() do
    @mapping
    |> Enum.map(fn {_, mod} -> mod.all() end)
    |> List.flatten()
  end

  for {vendor_mod, mod} <- @mapping do
    def get_by_vendor(unquote(vendor_mod.vendor_info().id)) do
      {:ok, unquote(mod).all()}
    end

    def get_by_vendor(unquote(vendor_mod)) do
      get_by_vendor(unquote(vendor_mod).vendor_info().id)
    end
  end

  def get_by_vendor(%{id: id}) do
    get_by_vendor(id)
  end

  def get_by_vendor(_) do
    {:error, :not_found}
  end
end
