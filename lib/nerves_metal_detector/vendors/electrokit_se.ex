defmodule NervesMetalDetector.Vendors.ElectrokitSe do
  alias NervesMetalDetector.Vendors.Vendor

  @behaviour Vendor

  @impl Vendor
  def vendor_info() do
    %Vendor{
      id: "electrokitse",
      name: "electro:kit",
      country: :se,
      homepage: "https://www.electrokit.com"
    }
  end

  defmodule ProductUpdate do
    @enforce_keys [:url, :sku]
    defstruct [:url, :sku]
  end
end

defimpl NervesMetalDetector.Inventory.ProductAvailability.Fetcher,
  for: NervesMetalDetector.Vendors.ElectrokitSe.ProductUpdate do
  alias NervesMetalDetector.Vendors.ElectrokitSe

  def fetch_availability(%ElectrokitSe.ProductUpdate{url: url, sku: sku}) do
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
         {:parse_json_info, json_info} when json_info not in [%{}] <-
           {:parse_json_info, parse_json_info(parsed)},
         {:parse_currency, currency} when not is_nil(currency) <-
           {:parse_currency, parse_currency(json_info)},
         {:parse_price, price} when not is_nil(price) <- {:parse_price, parse_price(json_info)},
         {:parse_item_url, item_url} when not is_nil(item_url) <-
           {:parse_item_url, parse_item_url(json_info)},
         {:parse_in_stock, in_stock} <- {:parse_in_stock, parse_in_stock(json_info)},
         {:parse_items_in_stock, items_in_stock} <-
           {:parse_items_in_stock, parse_items_in_stock(parsed)} do
      data = %{
        sku: sku,
        vendor: ElectrokitSe.vendor_info().id,
        url: item_url,
        in_stock: in_stock,
        items_in_stock: items_in_stock,
        price: Money.new!(String.to_atom(currency), "#{price}")
      }

      {:ok, data}
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end

  defp parse_json_info(html_tree) do
    html_tree
    |> Floki.find("[type=\"application/ld+json\"]")
    |> Enum.map(fn item ->
      parse_result = item |> Floki.children() |> Enum.at(0) |> Jason.decode()

      case parse_result do
        {:ok, parsed} -> parsed
        _ -> %{}
      end
    end)
    |> Enum.reverse()
    |> Enum.reduce(&Map.merge(&2, &1))
    |> Map.get("@graph")
    |> Enum.find(&(&1["@type"] === "Product"))
  end

  defp parse_currency(json_info) do
    get_in(json_info, ["offers", Access.at(0), "priceCurrency"])
  end

  defp parse_price(json_info) do
    get_in(json_info, ["offers", Access.at(0), "price"])
  end

  defp parse_item_url(json_info) do
    get_in(json_info, ["offers", Access.at(0), "url"])
  end

  defp parse_in_stock(json_info) do
    case get_in(json_info, ["offers", Access.at(0), "availability"]) do
      "http://schema.org/InStock" -> true
      "https://schema.org/InStock" -> true
      _ -> false
    end
  end

  defp parse_items_in_stock(html_tree) do
    with product_info when product_info not in [nil, []] <-
           Floki.find(html_tree, ".product-info"),
         in_stock when in_stock not in [nil, []] <- Floki.find(product_info, ".in-stock"),
         text when is_binary(text) and text not in [""] <- Floki.text(in_stock),
         {value, _} <- Integer.parse(text) do
      value
    else
      _ -> nil
    end
  end
end
