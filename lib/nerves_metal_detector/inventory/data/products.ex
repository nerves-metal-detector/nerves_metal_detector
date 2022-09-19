defmodule NervesMetalDetector.Inventory.Data.Products do
  @product_lists [
    NervesMetalDetector.Inventory.Data.Products.Rpi
  ]

  @items @product_lists |> Enum.map(& &1.all()) |> List.flatten()

  def all(), do: @items

  for item <- @items do
    def get_by_sku(unquote(item.sku)) do
      {:ok, unquote(Macro.escape(item))}
    end

    def get_by_sku(unquote(String.downcase(item.sku))) do
      {:ok, unquote(Macro.escape(item))}
    end
  end

  def get_by_sku(_) do
    {:error, :not_found}
  end
end
