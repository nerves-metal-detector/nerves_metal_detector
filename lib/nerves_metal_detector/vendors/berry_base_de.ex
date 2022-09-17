defmodule NervesMetalDetector.Vendors.BerryBaseDe do
  alias NervesMetalDetector.Vendor

  @behaviour Vendor

  @impl Vendor
  def vendor_info() do
    %Vendor{
      id: "berrybasede",
      name: "BerryBase",
      country: :de,
      homepage: "https://www.berrybase.de"
    }
  end

  defmodule ProductUpdate do
    @enforce_keys [:url]
    defstruct [:url, :sku]
  end
end

defimpl NervesMetalDetector.Inventory.ProductAvailability.Fetcher,
  for: NervesMetalDetector.Vendors.BerryBaseDe.ProductUpdate do
  alias NervesMetalDetector.Vendors.BerryBaseDe

  def fetch_availability(%BerryBaseDe.ProductUpdate{url: url, sku: explicit_sku}) do
    with {:load_body, {:ok, %{body: body}}} when body not in [nil, ""] <-
           {:load_body, HTTPoison.get(url, [], follow_redirect: true)},
         {:parse_document, parsed} when parsed not in [nil, []] <-
           {:parse_document, Floki.parse_document!(body)},
         {:parse_buybox, buybox} when buybox not in [nil, []] <-
           {:parse_buybox, parse_buybox(parsed)},
         {:parse_currency, currency} when not is_nil(currency) <-
           {:parse_currency, parse_currency(buybox)},
         {:parse_price, price} when not is_nil(price) <- {:parse_price, parse_price(buybox)},
         {:parse_sku, sku} when not is_nil(sku) <- {:parse_sku, parse_sku(parsed)},
         {:parse_item_url, item_url} when not is_nil(item_url) <-
           {:parse_item_url, parse_item_url(parsed)},
         {:parse_in_stock, in_stock} <- {:parse_in_stock, parse_in_stock(buybox)},
         {:parse_items_in_stock, items_in_stock} <-
           {:parse_items_in_stock, parse_items_in_stock(buybox)} do
      sku =
        case explicit_sku do
          nil -> sku
          value -> value
        end

      data = %{
        sku: sku,
        vendor: BerryBaseDe.vendor_info().id,
        url: item_url,
        in_stock: in_stock,
        items_in_stock: items_in_stock,
        price: Money.new(String.to_atom(currency), price)
      }

      {:ok, data}
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end

  defp parse_buybox(html_tree) do
    Floki.find(html_tree, "#product--buybox")
  end

  defp parse_currency(html_tree) do
    Floki.find(html_tree, "[itemprop=priceCurrency]") |> Floki.attribute("content") |> Enum.at(0)
  end

  defp parse_price(html_tree) do
    Floki.find(html_tree, "[itemprop=price]") |> Floki.attribute("content") |> Enum.at(0)
  end

  defp parse_sku(html_tree) do
    Floki.find(html_tree, "[itemprop=sku]") |> Floki.attribute("content") |> Enum.at(0)
  end

  defp parse_item_url(html_tree) do
    Floki.find(html_tree, "[itemprop=url]") |> Floki.attribute("content") |> Enum.at(0)
  end

  defp parse_in_stock(html_tree) do
    case Floki.find(html_tree, ".product--available") do
      [] -> false
      _ -> true
    end
  end

  defp parse_items_in_stock(html_tree) do
    with available when available not in [nil, []] <-
           Floki.find(html_tree, "#products-available-in-house"),
         text when is_binary(text) <- Floki.text(available),
         {value, _} <- Integer.parse(text) do
      value
    else
      _ -> nil
    end
  end
end
