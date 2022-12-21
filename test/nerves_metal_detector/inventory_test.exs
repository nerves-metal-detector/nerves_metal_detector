defmodule NervesMetalDetector.InventoryTest do
  use NervesMetalDetector.DataCase

  alias NervesMetalDetector.Inventory
  alias NervesMetalDetector.Inventory.Product
  alias NervesMetalDetector.Inventory.ProductAvailabilitySnapshot
  alias NervesMetalDetector.Vendors.Vendor
  alias NervesMetalDetector.Repo

  describe "products" do
    test "products/0 returns a list of products" do
      products = Inventory.products()

      assert Enum.count(products) >= 0

      for product <- products do
        assert %Inventory.Product{} = product
      end
    end

    test "get_product_by_sku/1 returns a single product if found" do
      product = Inventory.products() |> Enum.at(0)

      assert {:ok, ^product} = Inventory.get_product_by_sku(product.sku)
      assert {:ok, ^product} = Inventory.get_product_by_sku(String.downcase(product.sku))
      assert {:error, :not_found} = Inventory.get_product_by_sku("foo")
    end
  end

  describe "product update items" do
    test "product_update_items/0 returns a list of product update items" do
      items = Inventory.product_update_items()

      assert Enum.count(items) >= 0

      for item <- items do
        assert is_struct(item) === true
      end
    end

    test "product update items must have implementations for the Inventory.ProductAvailability.Fetcher protocol" do
      items = Inventory.product_update_items()

      for item <- items do
        assert Protocol.assert_impl!(Inventory.ProductAvailability.Fetcher, item.__struct__) ===
                 :ok
      end
    end
  end

  describe "product availability" do
    def product_availability_fixture(sku, vendor, rest \\ []) do
      {:ok, item} =
        rest
        |> Enum.into(%{
          sku: sku,
          vendor: vendor,
          url: "https://testing.com",
          in_stock: false,
          items_in_stock: nil,
          price: Money.new(:EUR, 100),
          fetched_at: DateTime.now!("Etc/UTC")
        })
        |> Inventory.store_product_availability()

      item
    end

    test "list_product_availabilities/0 lists all items sorted by :in_stock, :sku and :vendor" do
      item1 = product_availability_fixture("sku1", "vendor", in_stock: false)
      item2 = product_availability_fixture("sku2", "vendor", in_stock: true)
      item3 = product_availability_fixture("sku3", "vendor", in_stock: false)
      item4 = product_availability_fixture("sku4", "vendor2", in_stock: true)
      item5 = product_availability_fixture("sku4", "vendor1", in_stock: true)

      assert [^item2, ^item5, ^item4, ^item1, ^item3] = Inventory.list_product_availabilities()
    end

    test "hydrate_product_availability/1 applies vendor and product info to the item" do
      item1 =
        product_availability_fixture("CM4001008", "berrybasede", in_stock: false)
        |> Inventory.hydrate_product_availability()

      assert %Vendor{id: "berrybasede"} = item1.vendor_info
      assert %Product{sku: "CM4001008"} = item1.product_info

      item2 =
        product_availability_fixture("CM4001008", "vendor1", in_stock: false)
        |> Inventory.hydrate_product_availability()

      assert item2.vendor_info == nil
      assert %Product{sku: "CM4001008"} = item2.product_info

      item3 =
        product_availability_fixture("sku1", "berrybasede", in_stock: false)
        |> Inventory.hydrate_product_availability()

      assert %Vendor{id: "berrybasede"} = item3.vendor_info
      assert item3.product_info == nil

      item4 =
        product_availability_fixture("sku1", "vendor1", in_stock: false)
        |> Inventory.hydrate_product_availability()

      assert item4.vendor_info == nil
      assert item4.product_info == nil
    end

    test "store_product_availability/1 upserts the given arguments into the database" do
      fetched_at = DateTime.now!("Etc/UTC")

      {:ok, item1} =
        Inventory.store_product_availability(%{
          sku: "sku1",
          vendor: "vendor",
          url: "https://testing.com",
          in_stock: false,
          items_in_stock: nil,
          price: Money.new(:EUR, 100),
          fetched_at: fetched_at
        })

      assert [^item1] = Inventory.list_product_availabilities()

      Inventory.store_product_availability(%{
        sku: "sku1",
        vendor: "vendor",
        url: "https://testing.com",
        in_stock: false,
        items_in_stock: nil,
        price: Money.new(:EUR, 100),
        fetched_at: fetched_at
      })

      assert Enum.count(Inventory.list_product_availabilities()) === 1

      Inventory.store_product_availability(%{
        sku: "sku2",
        vendor: "vendor",
        url: "https://testing.com",
        in_stock: false,
        items_in_stock: nil,
        price: Money.new(:EUR, 100),
        fetched_at: fetched_at
      })

      assert Enum.count(Inventory.list_product_availabilities()) === 2
    end

    test "store_product_availability/1 additionally stores product availability snapshots" do
      import Ecto.Query

      base_data = %{
        sku: "sku1",
        vendor: "vendor",
        url: "https://testing.com",
        in_stock: false,
        items_in_stock: nil,
        price: Money.new(:EUR, 100)
      }

      {:ok, _} =
        Map.put(base_data, :fetched_at, ~U[2022-12-21 21:00:00.000000Z])
        |> Inventory.store_product_availability()

      assert Repo.one(from pa in ProductAvailabilitySnapshot, select: fragment("count(*)")) == 1

      # Expecting no new entry because the timestamp is the same
      {:ok, _} =
        Map.put(base_data, :fetched_at, ~U[2022-12-21 21:00:00.000000Z])
        |> Inventory.store_product_availability()

      assert Repo.one(from pa in ProductAvailabilitySnapshot, select: fragment("count(*)")) == 1

      # Expecting new entry because timestamp changed
      {:ok, _} =
        Map.put(base_data, :fetched_at, ~U[2022-12-21 22:00:00.000000Z])
        |> Inventory.store_product_availability()

      assert Repo.one(from pa in ProductAvailabilitySnapshot, select: fragment("count(*)")) == 2

      # Expecting new entry because of different data
      {:ok, _} =
        base_data
        |> Map.put(:vendor, "vendor2")
        |> Map.put(:fetched_at, ~U[2022-12-21 22:00:00.000000Z])
        |> Inventory.store_product_availability()

      assert Repo.one(from pa in ProductAvailabilitySnapshot, select: fragment("count(*)")) == 3
    end
  end
end
