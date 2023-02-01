defmodule NervesMetalDetectorWeb.VendorProductAvailabilityChart do
  alias NervesMetalDetector.Inventory.ProductAvailabilitySnapshot
  # alias NervesMetalDetector.TimeSeries

  @availability_stroke "#93c5fd"
  @availability_fill "#93c5fd4c"
  @price_stroke "#eab308"
  @price_dash [10, 10]

  def payload(snapshots) do
    timestamps =
      Enum.sort(
        for(%{fetched_at: t} <- snapshots, uniq: true, do: t),
        DateTime
      )

    has_count = has_count?(snapshots)
    currency = currency(snapshots)

    # Example for removing consecutive duplicates. Currently, all data points are sent to the chart so that the user can see when the data was fetched.
    #    {price_snapshots, _} = TimeSeries.consecutive_dedup(snapshots, fn %ProductAvailabilitySnapshot{} = snapshot, index, total_count ->
    #      {DateTime.to_date(snapshot.fetched_at), snapshot.price, index === (total_count - 1)}
    #      {snapshot.price, index === (total_count - 1)}
    #    end)
    #
    #    {stock_snapshots, _} = TimeSeries.consecutive_dedup(snapshots, fn %ProductAvailabilitySnapshot{} = snapshot, index, total_count ->
    #      value =
    #        case has_count do
    #          true -> snapshot.items_in_stock
    #          false -> snapshot.in_stock
    #        end
    #
    #      {value, index === (total_count - 1)}
    #    end)

    price_mapping =
      Map.new(snapshots, &{&1.fetched_at, Decimal.to_float(Money.to_decimal(&1.price))})

    stock_mapping =
      case has_count do
        true -> Map.new(snapshots, fn s ->
          count = case s.in_stock do
            true -> s.items_in_stock || 1
            false -> 0
          end

          {s.fetched_at, count}
        end)
        false -> Map.new(snapshots, &{&1.fetched_at, &1.in_stock})
      end

    series_data =
      Enum.map([stock_mapping, price_mapping], fn mapping ->
        Enum.map(timestamps, &Map.get(mapping, &1))
      end)

    %{
      data: [Enum.map(timestamps, &DateTime.to_unix/1)] ++ series_data,
      chart_opts: %{
        series: series(has_count, currency),
        axes: axes(has_count, currency),
        scales: scales(has_count)
      }
    }
  end

  def currency(%ProductAvailabilitySnapshot{price: price}) do
    Money.to_currency_code(price)
  end

  def currency(snapshots) when is_list(snapshots) do
    Enum.at(snapshots, 0) |> currency()
  end

  def has_count?(snapshots) do
    Enum.any?(snapshots, fn %{in_stock: in_stock, items_in_stock: items_in_stock} ->
      in_stock === true && items_in_stock !== nil
    end)
  end

  def series(has_stock_count, currency) do
    stock_series =
      case has_stock_count do
        true ->
          %{
            label: "In Stock",
            scale: "stock",
            width: 2,
            stroke: @availability_stroke,
            fill: @availability_fill,
            points: %{
              show: false
            }
          }

        false ->
          %{
            label: "Availability",
            scale: "stock",
            value_mapping: %{
              false => "out of stock",
              true => "in stock"
            },
            stroke: @availability_stroke,
            fill: @availability_fill,
            points: %{
              show: false
            }
          }
      end

    [
      %{},
      stock_series,
      %{
        label: "Price",
        scale: "price",
        currency: currency,
        width: 2,
        stroke: @price_stroke,
        dash: @price_dash,
        points: %{
          show: false
        }
      }
    ]
  end

  def axes(has_stock_count, currency) do
    stock_axis =
      case has_stock_count do
        true ->
          %{
            scale: "stock"
          }

        false ->
          %{
            scale: "stock",
            splits: [false, true],
            values: ["out of stock", "in stock"]
          }
      end

    [
      %{},
      stock_axis,
      %{
        side: 1,
        scale: "price",
        grid: %{
          show: false
        },
        currency: currency
      }
    ]
  end

  def scales(has_stock_count) do
    stock_scale =
      case has_stock_count do
        true ->
          %{
            range: %{
              min: %{
                soft: 0,
                hard: 0,
                mode: 1
              },
              max: %{
                pad: 0.1
              }
            }
          }

        false ->
          %{
            range: [false, true]
          }
      end

    %{
      stock: stock_scale,
      price: %{
        range: %{
          min: %{
            pad: 1.2,
            hard: 0,
            soft: 0
          },
          max: %{
            pad: 1
          }
        }
      }
    }
  end
end
