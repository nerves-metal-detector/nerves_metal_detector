defmodule NervesMetalDetector.Vendors.BotlandPl do
  alias NervesMetalDetector.Vendors.Vendor

  @behaviour Vendor

  @impl Vendor
  def vendor_info() do
    %Vendor{
      id: "botlandpl",
      name: "Botland",
      country: :pl,
      homepage: "https://botland.com.pl"
    }
  end

  defmodule ProductUpdate do
    @enforce_keys [:url, :sku]
    defstruct [:url, :sku]
  end
end

defimpl NervesMetalDetector.Inventory.ProductAvailability.Fetcher,
  for: NervesMetalDetector.Vendors.BotlandPl.ProductUpdate do
  alias NervesMetalDetector.Vendors.BotlandPl

  def fetch_availability(%BotlandPl.ProductUpdate{url: url, sku: sku}) do
    options = [
      follow_redirect: true,
      ssl: [
        {:versions, :ssl.versions()[:supported]},
        {:verify, :verify_peer},
        {:cacertfile, :certifi.cacertfile()},
        {:verify_fun, &:ssl_verify_hostname.verify_fun/3},
        {:customize_hostname_check,
         [
           match_fun: :public_key.pkix_verify_hostname_match_fun(:https)
         ]}
      ]
    ]

    with {:load_body, {:ok, %{body: body}}} when body not in [nil, ""] <-
           {:load_body, HTTPoison.get(url, [], options)},
         {:parse_document, parsed} when parsed not in [nil, []] <-
           {:parse_document, Floki.parse_document!(body)},
         {:parse_product, product} when product not in [nil, []] <-
           {:parse_product, parse_product(parsed)},
         {:parse_currency, currency} when not is_nil(currency) <-
           {:parse_currency, parse_currency(product)},
         {:parse_price, price} when not is_nil(price) <- {:parse_price, parse_price(product)},
         {:parse_item_url, item_url} when not is_nil(item_url) <-
           {:parse_item_url, parse_item_url(product)},
         {:parse_in_stock, in_stock} <- {:parse_in_stock, parse_in_stock(product)},
         {:parse_items_in_stock, items_in_stock} <-
           {:parse_items_in_stock, parse_items_in_stock(product)} do
      data = %{
        sku: sku,
        vendor: BotlandPl.vendor_info().id,
        url: item_url,
        in_stock: in_stock,
        items_in_stock: items_in_stock,
        price: Money.new!(String.to_atom(currency), price)
      }

      {:ok, data}
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end

  defp parse_product(html_tree) do
    Floki.find(html_tree, "[itemtype=\"https://schema.org/Product\"]")
  end

  defp parse_currency(html_tree) do
    Floki.find(html_tree, "[itemprop=priceCurrency]") |> Floki.attribute("content") |> Enum.at(0)
  end

  defp parse_price(html_tree) do
    Floki.find(html_tree, "[itemprop=price]") |> Floki.attribute("content") |> Enum.at(0)
  end

  defp parse_item_url(html_tree) do
    Floki.find(html_tree, "[itemprop=url]")
    |> Floki.attribute("content")
    |> Enum.at(0)
    |> URI.parse()
    |> Map.put(:scheme, "https")
    |> URI.to_string()
  end

  defp parse_in_stock(html_tree) do
    availability =
      Floki.find(html_tree, "[itemprop=availability]")
      |> Floki.attribute("href")
      |> Enum.at(0)

    case availability do
      "https://schema.org/InStock" -> true
      _ -> false
    end
  end

  defp parse_items_in_stock(html_tree) do
    with data_text when data_text not in [nil, []] <-
           Floki.attribute(html_tree, ".product-availability-info__box", "data-text"),
         text when is_binary(text) <- Enum.at(data_text, 0),
         scanned <- Cldr.Number.Parser.scan(text),
         number when number not in [0] <- Enum.find(scanned, &is_number/1) do
      number
    else
      _ -> nil
    end
  end
end
