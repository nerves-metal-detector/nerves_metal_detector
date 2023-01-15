defmodule NervesMetalDetector.TimeSeries do
  def consecutive_dedup(enumerable, fun) do
    total_count = Enum.count(enumerable)

    result =
      Enum.reduce(enumerable, %{index: 0, keep: [], discard: [], last_val: nil}, fn x, acc ->
        val = fun.(x, acc.index, total_count)

        case acc.index do
          0 ->
            %{acc | index: acc.index + 1, keep: [x | acc.keep], last_val: val}

          _ ->
            {keep, discard} =
              case acc.last_val === val do
                true -> {acc.keep, [x | acc.discard]}
                false -> {[x | acc.keep], acc.discard}
              end

            %{acc | index: acc.index + 1, keep: keep, discard: discard, last_val: val}
        end
      end)

    {Enum.reverse(result.keep), Enum.reverse(result.discard)}
  end
end
