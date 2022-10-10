defmodule NervesMetalDetector.Vendors.SparkfunUs do
  alias NervesMetalDetector.Vendors.Vendor

  @behaviour Vendor

  @impl Vendor
  def vendor_info() do
    %Vendor{
      id: "sparkfunus",
      name: "Sparkfun",
      country: :us,
      homepage: "https://www.sparkfun.com"
    }
  end

  defmodule ProductUpdate do
    @enforce_keys [:url, :sku]
    defstruct [:url, :sku]
  end
end

defimpl NervesMetalDetector.Inventory.ProductAvailability.Fetcher,
  for: NervesMetalDetector.Vendors.SparkfunUs.ProductUpdate do
  alias NervesMetalDetector.Vendors.SparkfunUs

  def fetch_availability(%SparkfunUs.ProductUpdate{url: url, sku: sku}) do
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
         {:parse_product_offer, product_offer} when product_offer not in [nil, []] <-
           {:parse_product_offer, parse_product_offer(parsed)},
         {:parse_currency, currency} when not is_nil(currency) <-
           {:parse_currency, parse_currency(product_offer)},
         {:parse_price, price} when not is_nil(price) <-
           {:parse_price, parse_price(product_offer)},
         {:parse_item_url, item_url} when not is_nil(item_url) <-
         {:parse_item_url, parse_item_url(parsed)},
           {:parse_in_stock, in_stock} <- {:parse_in_stock, parse_in_stock(product_offer)} do
      data = %{
        sku: sku,
        vendor: SparkfunUs.vendor_info().id,
        url: item_url,
        in_stock: in_stock,
        items_in_stock: nil,
        price: Money.new!(String.to_atom(currency), price)

        ## OLD STUFF ABOVE ##

        # sku: sku,
        # vendor: SparkfunUs.vendor_info().id,
        # url: item_url,
        # in_stock: false,
        # items_in_stock: nil,
        # price: Money.new!(String.to_atom("USD"), "12")
      }

      {:ok, data}
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end

  defp parse_product_offer(html_tree) do
    Floki.find(html_tree, "[itemprop=offers]")
  end


  defp parse_currency(html_tree) do
    Floki.find(html_tree, "[itemprop=priceCurrency]") |> Floki.attribute("content") |> Enum.at(0)
  end

  defp parse_price(html_tree) do
    Floki.find(html_tree, "[itemprop=price]") |> Floki.attribute("content") |> Enum.at(0)
  end

  defp parse_item_url(html_tree) do
    Floki.find(html_tree, "[rel=canonical]")
    |> Enum.at(0)
    |> Floki.attribute("href")
    |> Enum.at(0)
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
end





# Mix.install([
#   {:httpoison, "~> 1.8"},
#   {:floki, "~> 0.33.1"},
#   {:jason, "~> 1.4"},
# ])


# {:ok, %{body: body}} = HTTPoison.get("https://www.sparkfun.com/products/18713")
#     parsed = Floki.parse_document!(body)


# ben = Floki.find(parsed, "[itemprop=offers]")


# Floki.find(ben, "[itemprop=priceCurrency]") |> Floki.attribute("content") |> Enum.at(0)


# Floki.find(ben, "[itemprop=price]") |> Floki.attribute("content") |> Enum.at(0)


# Floki.find(ben, "[rel=canonical]")
#     |> Enum.at(0)
#     |> Floki.attribute("href")
#     |> Enum.at(0)
