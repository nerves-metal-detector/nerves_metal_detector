defmodule NervesMetalDetector do
  @moduledoc """
  NervesMetalDetector keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias NervesMetalDetector.Jobs.ProductUpdate
  alias NervesMetalDetector.Inventory

  def schedule_product_updates() do
    Inventory.product_update_items()
    |> schedule_product_updates()

    :ok
  end

  def schedule_product_updates(items) do
    items
    |> distribute_product_update_items()
    |> Enum.map(&ProductUpdate.encode_args/1)
    |> Enum.map(&ProductUpdate.new/1)
    |> Enum.map(&Oban.insert/1)

    :ok
  end

  defp distribute_product_update_items(items) do
    items
    |> Enum.chunk_by(fn item ->
      item.__struct__
    end)
    |> interleave()
  end

  defp interleave(chunks, list \\ []) do
    {list, chunks} =
      Enum.reduce(chunks, {list, []}, fn x, {l, c} ->
        [item | rest] = x
        new_list = [item | l]

        case rest do
          [] -> {new_list, c}
          rest -> {new_list, [rest | c]}
        end
      end)

    case chunks do
      [] -> Enum.reverse(list)
      chunks -> interleave(Enum.reverse(chunks), list)
    end
  end
end
