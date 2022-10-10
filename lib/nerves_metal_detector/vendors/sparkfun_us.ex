defmodule NervesMetalDetector.Vendors.SparkfunUs do
  alias NervesMetalDetector.Vendors.Vendor

  @behaviour Vendor

  @impl Vendor
  def vendor_info() do
    %Vendor{
      id: "sparkfunus",
      name: "Sparkfun",
      country: :us,
      homepage: "https://www.sparkfun.com/"
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
         {:parse_product, product} when product not in [nil, []] <-
           {:parse_product, parse_product(parsed)},
         {:parse_currency, currency} when not is_nil(currency) <-
           {:parse_currency, parse_currency(product)},
         {:parse_price, price} when not is_nil(price) <-
           {:parse_price, parse_price(product)},
         {:parse_item_url, item_url} when not is_nil(item_url) <-
         {:parse_item_url, parse_item_url(parsed)} do
        #    {:parse_in_stock, in_stock} <- {:parse_in_stock, parse_in_stock(product)} do
      data = %{
        # sku: sku,
        # vendor: SparkfunUs.vendor_info().id,
        # url: item_url,
        # in_stock: in_stock,
        # items_in_stock: nil,
        # price: Money.new!(String.to_atom(currency), price)

        ## OLD STUFF ABOVE ##

        sku: sku,
        vendor: SparkfunUs.vendor_info().id,
        url: "https://google.com",
        in_stock: false,
        items_in_stock: nil,
        price: Money.new!(String.to_atom("USD"), "12")
      }

      {:ok, data}
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end

  defp parse_product(html_tree) do
    Floki.find(html_tree, "[itemtype=\"http://schema.org/Offer\"]")
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

#   defp parse_in_stock(html_tree) do
#     availability =
#       Floki.find(html_tree, "[itemprop=availability]")
#       |> Floki.attribute("content")
#       |> Enum.at(0)

#     case availability do
#       "http://schema.org/InStock" -> true
#       _ -> false
    end
#   end
# end





#Ecto.Changeset<action: :insert, changes: %{fetched_at: ~U[2022-10-10 01:00:40Z], 
# sku: "RPI3-MODBP", vendor: "sparkfunus"}, 
# errors: [url: {"is invalid", [type: :string, validation: :cast]}, 
# in_stock: {"is invalid", [type: :boolean, validation: :cast]}, 
# price: {"is invalid", [type: {:parameterized, Money.Ecto.Composite.Type, []}, validation: :cast]}], 
# data: #NervesMetalDetector.Inventory.ProductAvailability<>, valid?: false>


