defmodule Accumulate do
  @doc """
    Given a list and a function, apply the function to each list item and
    replace it with the function's return value.

    Returns a list.

    ## Examples

      iex> Accumulate.accumulate([], fn(x) -> x * 2 end)
      []

      iex> Accumulate.accumulate([1, 2, 3], fn(x) -> x * 2 end)
      [2, 4, 6]

  """

  @spec accumulate(list, (any -> any)) :: list
  def accumulate([], fun), do: []
  def accumulate(list, fun) do
    Enum.reverse(accumulate(list, fun, []))
  end

  @spec accumulate(list, (any -> any), list) :: list
  defp accumulate([], _fun, acc), do: acc
  defp accumulate([head|tail], fun, acc) do
    accumulate(tail, fun, [fun.(head) | acc])
  end
end
