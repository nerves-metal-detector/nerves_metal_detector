defmodule NervesMetalDetector.Vendors.Vendor do
  @derive Phoenix.Param
  defstruct [:id, :name, :country, :homepage]

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          country: atom,
          homepage: String.t()
        }

  @callback vendor_info() :: __MODULE__.t()

  def display_name(%__MODULE__{name: name, country: country}) do
    "#{name} (#{country |> Atom.to_string() |> String.upcase()})"
  end
end
