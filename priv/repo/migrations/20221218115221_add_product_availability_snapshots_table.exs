defmodule NervesMetalDetector.Repo.Migrations.AddProductAvailabilitySnapshotsTable do
  use Ecto.Migration

  def change do
    create table(:product_availability_snapshots, primary_key: false) do
      add :sku,
          references(:product_availability, type: :string, column: :sku, with: [vendor: :vendor])

      add :vendor,
          references(:product_availability, type: :string, column: :vendor, with: [sku: :sku])

      add :in_stock, :boolean, null: false
      add :items_in_stock, :integer, null: true
      add :price, :money_with_currency, null: false
      add :fetched_at, :utc_datetime, null: false
    end

    create index(
             :product_availability_snapshots,
             [:sku, :vendor, :in_stock, :items_in_stock, :price, :fetched_at],
             unique: true,
             name: :product_availability_snapshots_constraint_index
           )

    create index(
             :product_availability_snapshots,
             [:sku, :vendor, :in_stock, :price, :fetched_at],
             unique: true,
             name: :product_availability_snapshots_constraint_items_in_stock_null_index,
             where: "items_in_stock IS NULL"
           )

    create index(:product_availability_snapshots, [:sku, :vendor])
    create index(:product_availability_snapshots, :sku)
    create index(:product_availability_snapshots, :vendor)
  end
end
