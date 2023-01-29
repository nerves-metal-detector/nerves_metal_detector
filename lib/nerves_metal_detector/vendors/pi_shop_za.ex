defmodule NervesMetalDetector.Vendors.PiShopZa do
  alias NervesMetalDetector.Vendors.Vendor

  @behaviour Vendor

  @impl Vendor
  def vendor_info() do
    %Vendor{
      id: "pishopza",
      name: "PiShop",
      country: :za,
      homepage: "https://www.pishop.co.za"
    }
  end

  defmodule ProductUpdate do
    @enforce_keys [:url, :sku]
    defstruct [:url, :sku]
  end
end

defimpl NervesMetalDetector.Inventory.ProductAvailability.Fetcher,
  for: NervesMetalDetector.Vendors.PiShopZa.ProductUpdate do
  alias NervesMetalDetector.Vendors.PiShopZa

  def fetch_availability(%PiShopZa.ProductUpdate{url: url, sku: sku}) do
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
         {:parse_price, price} when not is_nil(price) <-
           {:parse_price, parse_price(product)},
         {:parse_item_url, item_url} when not is_nil(item_url) <-
           {:parse_item_url, parse_item_url(parsed)},
         {:parse_in_stock, in_stock} <- {:parse_in_stock, parse_in_stock(product)},
         {:parse_items_in_stock, items_in_stock} <-
           {:parse_items_in_stock, parse_items_in_stock(product)} do
      data = %{
        sku: sku,
        vendor: PiShopZa.vendor_info().id,
        url: item_url,
        in_stock: in_stock,
        items_in_stock: items_in_stock,
        price: price
      }

      {:ok, data}
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end

  defp parse_product(html_tree) do
    Floki.find(html_tree, "#product_details")
  end

  defp parse_price(html_tree) do
    Floki.find(html_tree, ".productfilneprice")
    |> Enum.at(0)
    |> Floki.children()
    |> Enum.at(0)
    |> String.trim()
    |> Money.parse()
  end

  defp parse_item_url(html_tree) do
    Floki.find(html_tree, "[rel=canonical]")
    |> Enum.at(0)
    |> Floki.attribute("href")
    |> Enum.at(0)
  end

  defp parse_in_stock(html_tree) do
    Floki.find(html_tree, ".productprice > label")
    |> Floki.text()
    |> String.downcase()
    |> String.contains?("in stock")
  end

  defp parse_items_in_stock(html_tree) do
    Floki.find(html_tree, ".productprice > label")
    |> Floki.text()
    |> Cldr.Number.Parser.scan()
    |> Enum.find(&is_number/1)
  end
end
