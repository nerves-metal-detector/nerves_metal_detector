defmodule NervesMetalDetectorDev.RpiLocator do
  def fetch_vendors() do
    case HTTPoison.get("https://rpilocator.com") do
      {:ok, %{status_code: 200, body: body}} ->
        selector =
          "#navbarSupportedContent > ul > li:nth-child(1) > ul > div > div li a.filter-list"

        case Floki.parse_document(body) do
          {:ok, parsed} ->
            vendors =
              parsed
              |> Floki.find(selector)
              |> Enum.map(fn i ->
                value = Floki.attribute(i, "data-vendor") |> Enum.at(0)
                label = Floki.text(i)

                {label, value}
              end)
              |> Enum.filter(&(elem(&1, 1) !== ""))

            {:ok, vendors}

          _ ->
            :error
        end

      {:ok, %{status_code: 429}} ->
        {:error, :rate_limited}

      _ ->
        :error
    end
  end

  def fetch_items(vendor) do
    headers = [
      {"Accept", "application/json, text/javascript, */*; q=0.01"},
      {"X-Requested-With", "XMLHttpRequest"},
      {"referer", "https://rpilocator.com/?vendor=#{vendor}"}
    ]

    ts = System.os_time(:millisecond)
    url = "https://rpilocator.com/data.cfm?method=getProductTable&vendor=#{vendor}&_=#{ts}"

    with {:ok, %{status_code: 200, body: body}} <- HTTPoison.get(url, headers),
         {:ok, parsed_body} <- Jason.decode(body) do
      items =
        Enum.map(parsed_body["data"], fn item ->
          %{sku: item["sku"], url: item["link"]}
        end)

      {:ok, items}
    else
      {:ok, %{status_code: 429}} ->
        {:error, :rate_limited}

      _ ->
        :error
    end
  end
end
