defmodule NervesMetalDetector.Inventory.ProductAvailabilitySnapshot do
  use Ecto.Schema
  import Ecto.Changeset
  alias NervesMetalDetector.Repo

  @primary_key false

  @type t :: %__MODULE__{
          sku: String.t(),
          vendor: String.t(),
          in_stock: boolean,
          items_in_stock: non_neg_integer | nil,
          price: Money.t(),
          fetched_at: DateTime.t()
        }

  schema "product_availability_snapshots" do
    field :sku, :string, primary_key: true
    field :vendor, :string, primary_key: true
    field :in_stock, :boolean
    field :items_in_stock, :integer
    field :price, Money.Ecto.Composite.Type
    field :fetched_at, :utc_datetime
  end

  @doc false
  def changeset(%__MODULE__{} = product_availability_snapshot, attrs) do
    product_availability_snapshot
    |> cast(attrs, [:sku, :vendor, :in_stock, :items_in_stock, :price, :fetched_at])
    |> validate_required([:sku, :vendor, :in_stock, :price, :fetched_at])
    |> unique_constraint([:sku, :vendor, :in_stock, :items_in_stock, :price, :fetched_at],
      name: :product_availability_snapshots_constraint_index
    )
    |> unique_constraint([:sku, :vendor, :in_stock, :price, :fetched_at],
      name: :product_availability_snapshots_constraint_items_in_stock_null_index
    )
    |> foreign_key_constraint(:sku)
    |> foreign_key_constraint(:vendor)
  end

  def store(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> upsert()
  end

  def upsert_opts() do
    [
      on_conflict: :nothing,
      returning: true
    ]
  end

  def upsert(%Ecto.Changeset{} = changeset) do
    changeset
    |> Repo.insert(upsert_opts())
  end
end
