defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep([], _fun), do: []
  def keep(list, fun) do
    Enum.reverse(foldl(list, [], 
      fn acc, item -> keeper(acc, item, fun) end))
  end

  @spec keeper(list(any), any, fun :: (any -> boolean)) :: list(any)
  defp keeper(list, item, fun) do
    if fun.(item), do: [item | list], else: list
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard([], _fun), do: []
  def discard(list, fun) do
    Enum.reverse(foldl(list, [], 
      fn acc, item -> discarder(acc, item, fun) end))
  end

  @spec keeper(list(any), any, fun :: (any -> boolean)) :: list(any)
  defp discarder(list, item, fun) do
    unless fun.(item), do: [item | list], else: list
  end

  #foldl :: [a] -> b -> (b -> a -> b) -> b
  @spec foldl(list(any), any, fun :: (any -> any)) :: any
  defp foldl([], acc, _fun), do: acc
  defp foldl([head|tail], acc, fun) do
    foldl(tail, fun.(acc, head), fun)
  end
end
