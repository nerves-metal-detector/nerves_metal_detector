defmodule NervesMetalDetector.Vendors.SemafAt do
  alias NervesMetalDetector.Vendors.Vendor

  @behaviour Vendor

  @impl Vendor
  def vendor_info() do
    %Vendor{
      id: "semafat",
      name: "Semaf",
      country: :at,
      homepage: "https://electronics.semaf.at"
    }
  end

  defmodule ProductUpdate do
    @enforce_keys [:url, :sku]
    defstruct [:url, :sku]
  end
end

defimpl NervesMetalDetector.Inventory.ProductAvailability.Fetcher,
  for: NervesMetalDetector.Vendors.SemafAt.ProductUpdate do
  alias NervesMetalDetector.Vendors.SemafAt

  def fetch_availability(%SemafAt.ProductUpdate{url: url, sku: sku}) do
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

    # Semaf has "application/ld+json" data but in a wrong encoding and Jason cannot parse it,
    # so we parse the HTML instead.
    with {:load_body, {:ok, %{body: body}}} when body not in [nil, ""] <-
           {:load_body, HTTPoison.get(url, [], options)},
         {:parse_document, parsed} when parsed not in [nil, []] <-
           {:parse_document, Floki.parse_document!(body)},
         {:parse_json_info, json_info} when json_info not in [%{}] <-
           {:parse_json_info, parse_json_info(parsed)},
         {:parse_product_offer, product_offer} when product_offer not in [nil, []] <-
           {:parse_product_offer, parse_product_offer(parsed)},
         {:parse_currency, currency} when not is_nil(currency) <-
           {:parse_currency, parse_currency(json_info)},
         {:parse_price, price} when not is_nil(price) <-
           {:parse_price, parse_price(json_info)},
         {:parse_in_stock, in_stock} <- {:parse_in_stock, parse_in_stock(json_info)},
         {:parse_items_in_stock, items_in_stock} <- {:parse_items_in_stock, parse_items_in_stock(product_offer)} do
      data = %{
        sku: sku,
        vendor: SemafAt.vendor_info().id,
        url: url,
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

  defp parse_json_info(html_tree) do
    html_tree
    |> Floki.find("[type=\"application/ld+json\"]")
    |> Enum.map(fn item ->
      parse_result =
        item
        |> Floki.children()
        |> Enum.at(0)
        |> String.replace("\r", "")
        |> String.replace("\n", "")
        |> Jason.decode()

      case parse_result do
        {:ok, parsed} -> parsed
        _ -> %{}
      end
    end)
    |> Enum.reduce(&Map.merge(&2, &1))
  end

  defp parse_product_offer(html_tree) do
    Floki.find(html_tree, "#product-offer .product-offer")
  end

  defp parse_currency(json_info) do
    get_in(json_info, ["offers", "priceCurrency"])
  end

  defp parse_price(json_info) do
    get_in(json_info, ["offers", "price"])
  end

  defp parse_in_stock(json_info) do
    case get_in(json_info, ["offers", "availability"]) do
      "http://schema.org/InStock" -> true
      "https://schema.org/InStock" -> true
      _ -> false
    end
  end

  defp parse_items_in_stock(html_tree) do
    children = Floki.find(html_tree, ".delivery-status .status") |> Enum.at(0) |> Floki.children()

    with children when children not in [nil, []] <- children,
         text <- Floki.text(children) do

      items_in_stock =
        case Integer.parse(String.trim(text)) do
          {count, _} -> count
          _ -> nil
        end

      items_in_stock
    else
      _ -> nil
    end
  end
end
