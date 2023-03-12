defmodule NervesMetalDetector.Vendors.CoolComponentsUk do
  alias NervesMetalDetector.Vendors.Vendor

  @behaviour Vendor

  @impl Vendor
  def vendor_info() do
    %Vendor{
      id: "coolcomponentsuk",
      name: "Cool Components",
      country: :uk,
      homepage: "https://coolcomponents.co.uk"
    }
  end

  defmodule ProductUpdate do
    @enforce_keys [:url, :sku]
    defstruct [:url, :sku]
  end
end

defimpl NervesMetalDetector.Inventory.ProductAvailability.Fetcher,
  for: NervesMetalDetector.Vendors.CoolComponentsUk.ProductUpdate do
  alias NervesMetalDetector.Vendors.CoolComponentsUk

  def fetch_availability(%CoolComponentsUk.ProductUpdate{url: url, sku: sku}) do
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
         {:parse_currency, currency} when not is_nil(currency) <-
           {:parse_currency, parse_currency(parsed)},
         {:parse_price, price} when not is_nil(price) <- {:parse_price, parse_price(parsed)},
         {:parse_item_url, item_url} when not is_nil(item_url) <-
           {:parse_item_url, parse_item_url(parsed)},
         {:parse_in_stock, in_stock} <- {:parse_in_stock, parse_in_stock(parsed)},
         {:parse_items_in_stock, items_in_stock} <-
           {:parse_items_in_stock, parse_items_in_stock(parsed)} do
      data = %{
        sku: sku,
        vendor: CoolComponentsUk.vendor_info().id,
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

  defp parse_currency(html_tree) do
    Floki.find(html_tree, "[itemprop=priceCurrency]") |> Floki.attribute("content") |> Enum.at(0)
  end

  defp parse_price(html_tree) do
    Floki.find(html_tree, "[itemprop=price]") |> Floki.attribute("content") |> Enum.at(0)
  end

  defp parse_item_url(html_tree) do
    Floki.find(html_tree, "[itemprop=url]") |> Floki.attribute("content") |> Enum.at(0)
  end

  defp parse_in_stock(html_tree) do
    availability =
      Floki.find(html_tree, "[itemprop=availability]")
      |> Floki.attribute("content")
      |> Enum.at(0)

    case availability do
      "http://schema.org/InStock" -> true
      _ -> false
    end
  end

  defp parse_items_in_stock(html_tree) do
    with available when available not in [nil, []] <-
           Floki.find(html_tree, "#variant-inventory .var-inv"),
         text when is_binary(text) <- Floki.text(available),
         {value, _} <- Integer.parse(text) do
      value
    else
      _ -> nil
    end
  end
end
