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
    |> Enum.map(&ProductUpdate.encode_args/1)
    |> Enum.map(&ProductUpdate.new/1)
    |> Enum.map(&Oban.insert/1)

    :ok
  end
end
