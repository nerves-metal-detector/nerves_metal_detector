defmodule NervesMetalDetector.Vendors.ThePiHutUk do
  alias NervesMetalDetector.Vendors.Vendor

  @behaviour Vendor

  @impl Vendor
  def vendor_info() do
    %Vendor{
      id: "thepihutuk",
      name: "The PiHut",
      country: :uk,
      homepage: "https://thepihut.com/"
    }
  end

  defmodule ProductUpdate do
    @enforce_keys [:url, :sku]
    defstruct [:url, :sku]
  end
end

defimpl NervesMetalDetector.Inventory.ProductAvailability.Fetcher,
  for: NervesMetalDetector.Vendors.ThePiHutUk.ProductUpdate do
  alias NervesMetalDetector.Vendors.ThePiHutUk

  def fetch_availability(%ThePiHutUk.ProductUpdate{url: url, sku: sku}) do
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
         {:find_offer, offer} when not is_nil(offer) <-
           {:find_offer, find_offer(json_info, url)},
         {:parse_currency, currency} when not is_nil(currency) <-
           {:parse_currency, parse_currency(offer)},
         {:parse_price, price} when not is_nil(price) <- {:parse_price, parse_price(offer)},
         {:parse_item_url, item_url} when not is_nil(item_url) <-
           {:parse_item_url, parse_item_url(offer)},
         {:parse_in_stock, in_stock} <- {:parse_in_stock, parse_in_stock(offer)} do
      data = %{
        sku: sku,
        vendor: ThePiHutUk.vendor_info().id,
        url: item_url,
        in_stock: in_stock,
        items_in_stock: nil,
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
    |> Enum.reduce(&Map.merge(&2, &1))
  end

  defp find_offer(json_info, url) do
    with offers when is_list(offers) <- json_info["offers"] do
      Enum.find(offers, fn offer ->
        offer["url"] == url
      end)
    else
      _ -> nil
    end
  end

  defp parse_currency(offer) do
    offer["priceCurrency"]
  end

  defp parse_price(offer) do
    offer["price"]
  end

  defp parse_item_url(offer) do
    offer["url"]
  end

  defp parse_in_stock(offer) do
    case offer["availability"] do
      "https://schema.org/InStock" -> true
      _ -> false
    end
  end
end
