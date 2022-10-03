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
         {:parse_product_offer, product_offer} when product_offer not in [nil, []] <-
           {:parse_product_offer, parse_product_offer(parsed)},
         {:parse_currency, currency} when not is_nil(currency) <-
           {:parse_currency, parse_currency(product_offer)},
         {:parse_price, price} when not is_nil(price) <-
           {:parse_price, parse_price(product_offer)},
         {:parse_item_url, item_url} when not is_nil(item_url) <-
           {:parse_item_url, parse_item_url(product_offer)},
         {:parse_stock, {in_stock, items_in_stock}} <- {:parse_stock, parse_stock(product_offer)} do
      data = %{
        sku: sku,
        vendor: SemafAt.vendor_info().id,
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

  defp parse_product_offer(html_tree) do
    Floki.find(html_tree, "#product-offer .product-offer")
  end

  defp parse_currency(html_tree) do
    Floki.find(html_tree, "[itemprop=priceCurrency]") |> Floki.attribute("content") |> Enum.at(0)
  end

  defp parse_price(html_tree) do
    Floki.find(html_tree, "[itemprop=price]") |> Floki.attribute("content") |> Enum.at(0)
  end

  defp parse_item_url(html_tree) do
    Floki.find(html_tree, "[itemprop=url]") |> Enum.at(0) |> Floki.attribute("href") |> Enum.at(0)
  end

  defp parse_stock(html_tree) do
    children = Floki.find(html_tree, "#stock") |> Enum.at(0) |> Floki.children()

    with children when children not in [nil, []] <- children,
         classes <- Floki.attribute(children, "class") |> Enum.at(0) |> String.split(" "),
         text <- Floki.text(children) do
      in_stock = "status-2" in classes

      items_in_stock =
        case Integer.parse(String.trim(text)) do
          {count, _} -> count
          _ -> nil
        end

      {in_stock, items_in_stock}
    else
      value -> {:error, value}
    end
  end
end
