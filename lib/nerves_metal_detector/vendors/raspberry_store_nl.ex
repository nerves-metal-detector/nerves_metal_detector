defmodule NervesMetalDetector.Vendors.RaspberryStoreNl do
  alias NervesMetalDetector.Vendors.Vendor

  @behaviour Vendor

  @impl Vendor
  def vendor_info() do
    %Vendor{
      id: "raspberrystorenl",
      name: "RaspberryStore",
      country: :nl,
      homepage: "https://www.raspberrystore.nl"
    }
  end

  defmodule ProductUpdate do
    @enforce_keys [:url, :sku]
    defstruct [:url, :sku]
  end
end

defimpl NervesMetalDetector.Inventory.ProductAvailability.Fetcher,
  for: NervesMetalDetector.Vendors.RaspberryStoreNl.ProductUpdate do
  alias NervesMetalDetector.Vendors.RaspberryStoreNl

  def fetch_availability(%RaspberryStoreNl.ProductUpdate{url: url, sku: sku}) do
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
         {:parse_price, price} when not is_nil(price) <-
           {:parse_price, parse_price(body)},
         {:parse_in_stock, in_stock} <- {:parse_in_stock, parse_in_stock(parsed, body)} do
      data = %{
        sku: sku,
        vendor: RaspberryStoreNl.vendor_info().id,
        # store html does not contain url
        url: url,
        in_stock: in_stock,
        items_in_stock: nil,
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

  defp parse_price(body) do
    # When shops do weird things like <meta itemprop="price" content="27,95 €" />
    # one has to find other ways to get the price.
    # If "27,95 €" would have been "27.95 €", it could have been parsed by `Money.parse/1`.
    [_, price] = Regex.run(~r/productPrice = '(.+?)'/, body)
    price
  end

  defp parse_in_stock(html_tree, body) do
    # The itemprop meta tag contains InStock for all products, regardless their availability.
    # Doing some scetchy parsing here as well.
    [_, in_stock_value] = Regex.run(~r/availableNowValue = '(.+?)'/, body)
    availability_value = Floki.find(html_tree, "#availability_value") |> Floki.text()

    availability_value === in_stock_value
  end
end
