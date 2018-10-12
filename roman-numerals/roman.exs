defmodule Roman do
  @numerals %{1 => "I", 4 => "IV", 5 => "V", 9 => "IX",
              10 => "X", 40 => "XL", 50 => "L", 90 => "XC",
              100 => "C", 400 => "CD", 500 => "D", 900 => "CM", 1000 => "M"}
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    case Map.fetch(@numerals, number) do
      {:ok, val} -> val
      :error     -> convert(number, "")
    end
  end

  @spec convert(pos_integer, String.t()) :: String.t()
  defp convert(number, acc), do: convert(number, get_dividers(@numerals), acc)

  @spec convert(pos_integer, list(pos_integer), String.t()) :: String.t()
  defp convert(0, _, acc), do: acc
  defp convert(number, dividers, acc) do
    [biggest | _ ] = list = find_biggest_particle(number, dividers)
    numeral = Map.get(@numerals, biggest)
    convert(number-biggest, list, acc <> numeral)
  end

  @spec find_biggest_particle(pos_integer, list(pos_integer)) :: list(pos_integer)
  defp find_biggest_particle(number, dividers) do
    Enum.filter(dividers, &(&1 <= number))
  end

  @spec get_dividers(Map) :: list
  defp get_dividers(table) do
    table
    |> Map.keys
    |> Enum.sort(&(&1>=&2))
  end

end

