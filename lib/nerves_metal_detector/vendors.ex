defmodule NervesMetalDetector.Vendors do
  @moduledoc false

  alias NervesMetalDetector.Vendors

  @vendors [
    Vendors.BerryBaseDe
  ]

  def all() do
    @vendors
    |> Enum.map(& &1.vendor_info())
  end
end
