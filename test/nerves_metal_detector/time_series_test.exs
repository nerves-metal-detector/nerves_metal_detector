defmodule NervesMetalDetector.TimeSeriesTest do
  use NervesMetalDetector.DataCase

  alias NervesMetalDetector.TimeSeries

  describe "consecutive_dedup/2" do
    test "it deduplicates consecutive items based on the return value of the callback function" do
      items = [1, 1, 2, 2, 2, 3, 4, 2, 1, 1]
      {result, _} = TimeSeries.consecutive_dedup(items, fn x, _i, _t -> x end)

      assert ^result = [1, 2, 3, 4, 2, 1]
    end

    test "it also returns a list of discarded items" do
      items = [1, 1, 2, 2, 2, 3, 4, 2, 1, 1]
      {_, discarded} = TimeSeries.consecutive_dedup(items, fn x, _i, _t -> x end)

      assert ^discarded = [1, 2, 2, 1]
    end

    test "it also passes the current index and the total number of items to the callback function" do
      items = [1, 1, 2, 2, 2, 3, 4, 2, 1, 1]

      {result, discarded} =
        TimeSeries.consecutive_dedup(items, fn x, index, total_count ->
          {x, index === total_count - 1}
        end)

      assert ^result = [1, 2, 3, 4, 2, 1, 1]
      assert ^discarded = [1, 2, 2]
    end
  end
end
