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
    scrape_url = "https://rpilocator.com/?vendor=#{vendor}"

    second_request_headers = [
      {"Accept", "application/json, text/javascript, */*; q=0.01"},
      {"X-Requested-With", "XMLHttpRequest"},
      {"referer", scrape_url}
    ]

    with {:ok, %{status_code: 200, body: body, headers: headers}} <- HTTPoison.get(scrape_url),
         {:ok, parsed} <- Floki.parse_document(body),
         {:ok, info} <- find_js_block(parsed),
         {:ok, local_token} <- parse_local_token(info),
         {:ok, query_filter} <- parse_query_filter(info),
         ts <- System.os_time(:millisecond),
         url <-
           "https://rpilocator.com/data.cfm?method=getProductTable&token=#{local_token}&#{query_filter}&_=#{ts}",
         cookies <- extract_cookies_from_headers(headers),
         options <- build_request_options(cookies),
         {:ok, %{status_code: 200, body: body}} <-
           HTTPoison.get(url, second_request_headers, options),
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

  defp find_js_block(parsed) do
    content =
      parsed
      |> Floki.find("script[type=\"text/javascript\"]")
      |> Enum.at(1)
      |> Floki.children()
      |> Floki.text()

    cond do
      content not in [nil, ""] -> {:ok, content}
      true -> :error
    end
  end

  defp parse_local_token(info) do
    case Regex.run(~r/localToken="([[:alnum:]]+)"/, info) do
      [_, local_token] -> {:ok, local_token}
      _ -> :error
    end
  end

  defp parse_query_filter(info) do
    case Regex.run(~r/queryFilter="([[:alnum:]|=]*)"/, info) do
      [_, query_filter] -> {:ok, query_filter}
      _ -> :error
    end
  end

  defp extract_cookies_from_headers(headers) do
    headers
    |> Enum.filter(fn
      {"set-cookie", _} -> true
      _ -> false
    end)
    |> Enum.map(&parse_cookie_from_header/1)
  end

  defp parse_cookie_from_header({"set-cookie", cookie_string}) do
    [name_value | _] = String.split(cookie_string, ";")
    [name, value] = String.split(name_value, "=", parts: 2)

    {name, value}
  end

  defp build_request_options(cookies) do
    case cookies do
      nil ->
        []

      cookies ->
        cookies_formatted =
          cookies
          |> Enum.map(&format_cookie/1)
          |> Enum.join("; ")

        [hackney: [cookie: [cookies_formatted]]]
    end
  end

  defp format_cookie({name, value}) do
    name <> "=" <> value
  end
end
