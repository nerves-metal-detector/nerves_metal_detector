defmodule NervesMetalDetector.Vendors do
  @moduledoc false

  alias NervesMetalDetector.Vendors

  @vendors [
    Vendors.AdafruitUs,
    Vendors.BerryBaseDe,
    Vendors.BuyzeroDe,
    Vendors.McHobbyBe,
    Vendors.PimoroniUk,
    Vendors.PiShopCa,
    Vendors.PiShopCh,
    Vendors.PiShopUs,
    Vendors.RasppishopDe,
    Vendors.ReicheltDe,
    Vendors.SeeedStudioCn,
    Vendors.SemafAt,
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
