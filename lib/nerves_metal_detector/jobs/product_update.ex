defmodule NervesMetalDetector.Jobs.ProductUpdate do
  use Oban.Worker,
    queue: :product_updates,
    max_attempts: 3

  require Logger

  alias NervesMetalDetector.Inventory

  @impl Oban.Worker
  def perform(%Oban.Job{args: args}) do
    args = decode_args(args)

    with {:ok, result} <- Inventory.fetch_product_availability(args),
         data <- Map.put(result, :fetched_at, DateTime.now!("Etc/UTC")),
         {:sku_check, {:ok, _}, _} <- {:sku_check, Inventory.get_product_by_sku(data.sku), data},
         {:ok, _entry} <- Inventory.store_product_availability(data) do
      :ok
    else
      {:sku_check, {:error, _}, data} ->
        report_sku_check_error(args, data)
        {:error, :sku_not_found}

      {:error, reason} ->
        report_error(args, reason)
        {:error, reason}

      reason ->
        report_error(args, reason)
        {:error, reason}
    end
  end

  def encode_args(args) do
    module = to_string(args.__struct__)
    data = Map.from_struct(args)

    %{
      "module" => module,
      "data" => data
    }
  end

  def decode_args(%{"module" => module, "data" => data}) do
    module = Module.safe_concat(module, nil)
    data = Enum.into(data, Map.new(), fn {k, v} -> {to_atom(k), v} end)

    struct(module, data)
  end

  defp to_atom(value) when is_atom(value), do: value
  defp to_atom(value) when is_binary(value), do: String.to_existing_atom(value)

  defp report_sku_check_error(args, data) do
    Logger.error("""
    Fetched SKU is unknown!

    Job args:
    #{inspect(args)}

    Fetched data:
    #{inspect(data)}
    """)
  end

  defp report_error(args, reason) do
    Logger.error("""
    Product update job failed!

    Job args:
    #{inspect(args)}

    Error reason:
    #{inspect(reason)}
    """)
  end
end
