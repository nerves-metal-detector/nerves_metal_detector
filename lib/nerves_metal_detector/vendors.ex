defmodule NervesMetalDetector.Vendors do
  @moduledoc false

  alias NervesMetalDetector.Vendors

  @vendors [
    Vendors.AdafruitUs,
    Vendors.ArgonFortyCn,
    Vendors.BerryBaseDe,
    Vendors.BuyzeroDe,
    Vendors.BotlandCz,
    Vendors.BotlandDe,
    Vendors.BotlandEu,
    Vendors.BotlandPl,
    Vendors.CoolComponentsUk,
    Vendors.ChicagoElectronicDistributorsUs,
    Vendors.ElectrokitSe,
    Vendors.ElektorNl,
    Vendors.FarnellUk,
    Vendors.KamamiPl,
    Vendors.KubiiFr,
    Vendors.McHobbyBe,
    Vendors.MeloperoIt,
    Vendors.NewarkUs,
    Vendors.PiAustraliaAu,
    Vendors.PimoroniUk,
    Vendors.PiShopCa,
    Vendors.PiShopCh,
    Vendors.PiShopUs,
    Vendors.PiShopZa,
    Vendors.RapidUk,
    Vendors.RaspberryPiDk,
    Vendors.RaspberryStoreNl,
    Vendors.RasppishopDe,
    Vendors.ReicheltDe,
    Vendors.SeeedStudioCn,
    Vendors.SemafAt,
    Vendors.SparkfunUs,
    Vendors.ThePiHutUk,
    Vendors.ThreeThreeZeroOhmsMx,
    Vendors.TiendatecEs,
    Vendors.WelectronDe
  ]

  @vendor_items @vendors |> Enum.map(& &1.vendor_info())

  def all() do
    @vendor_items
  end

  for vendor <- @vendor_items do
    def get_by_id(unquote(vendor.id)) do
      {:ok, unquote(Macro.escape(vendor))}
    end
  end

  def get_by_id(_) do
    {:error, :not_found}
  end
end
