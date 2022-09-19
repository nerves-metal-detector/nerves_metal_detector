defmodule NervesMetalDetector.Vendors.Vendor do
  defstruct [:id, :name, :country, :homepage]

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          country: atom,
          homepage: String.t()
        }

  @callback vendor_info() :: __MODULE__.t()
end
