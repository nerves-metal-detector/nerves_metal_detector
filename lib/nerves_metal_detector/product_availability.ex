defmodule NervesMetalDetector.ProductAvailability do
  use Ecto.Schema
  import Ecto.Changeset
  alias NervesMetalDetector.Repo

  @primary_key false

  @type t :: %__MODULE__{
          sku: String.t(),
          vendor: String.t(),
          url: String.t(),
          in_stock: boolean,
          items_in_stock: non_neg_integer | nil,
          price: Money.t(),
          fetched_at: DateTime.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  schema "product_availability" do
    field :sku, :string, primary_key: true
    field :vendor, :string, primary_key: true
    field :url, :string
    field :in_stock, :boolean
    field :items_in_stock, :integer
    field :price, Money.Ecto.Composite.Type
    field :fetched_at, :utc_datetime
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(%__MODULE__{} = product_availability, attrs) do
    product_availability
    |> cast(attrs, [:sku, :vendor, :url, :in_stock, :items_in_stock, :price, :fetched_at])
    |> validate_required([:sku, :vendor, :url, :in_stock, :price, :fetched_at])
    |> unique_constraint([:sku, :vendor], name: :product_availability_pkey)
  end

  def store(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> upsert()
  end

  def upsert(%Ecto.Changeset{} = changeset) do
    changeset
    |> Repo.insert(
      on_conflict: {:replace_all_except, [:inserted_at]},
      conflict_target: [:sku, :vendor],
      returning: true
    )
  end

  defprotocol Fetcher do
    @type data :: %{
            sku: String.t(),
            vendor: String.t(),
            url: String.t(),
            in_stock: boolean,
            items_in_stock: non_neg_integer | nil,
            price: Money.t()
          }
    @spec fetch_availability(t) :: {:ok, data :: data} | {:error, reason :: term}
    def fetch_availability(t)
  end
end
