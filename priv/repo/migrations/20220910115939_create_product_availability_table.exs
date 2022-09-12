defmodule NervesMetalDetector.Repo.Migrations.CreateProductAvailabilityTable do
  use Ecto.Migration

  def change do
    create table(:product_availability, primary_key: false) do
      add :sku, :string, null: false, primary_key: true
      add :vendor, :string, null: false, primary_key: true
      add :url, :string, null: false
      add :in_stock, :boolean, null: false
      add :items_in_stock, :integer, null: true
      add :price, :money_with_currency, null: false

      add :fetched_at, :utc_datetime,
        null: false,
        default: fragment("timezone('UTC', now())")

      timestamps(type: :utc_datetime)
    end

    create index(:product_availability, [:sku, :vendor], unique: true)
    create index(:product_availability, :sku)
    create index(:product_availability, :vendor)
  end
end
