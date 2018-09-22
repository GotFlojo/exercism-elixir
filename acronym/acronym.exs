defmodule Acronym do

  @doc """
  Generate an acronym from a string.
  ## Example 
       iex> abbreviate("This is a string")
       "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> split_into_words
    |> capitalize
    |> extract_uppercase
    |> Enum.join("")
  end

  @spec capitalize([ String.t() ]) :: [ String.t() ]
  defp capitalize([]), do: []
  defp capitalize(words) do
    Enum.map(words, &capitalize_lower/1)
  end

  @spec capitalize_lower(String.t()) :: String.t()
  defp capitalize_lower(string) do
    if is_all_lower?(string) do
      String.capitalize(string)
    else
      string
    end
  end

  @spec extract_uppercase([ String.t() ]) :: [ String.t() ]
  defp extract_uppercase([]), do: []
  defp extract_uppercase(words) do
    Enum.flat_map(words, &(String.split(&1, ~r<\P{Lu}>, trim: true)))
  end

  @spec is_all_lower?(String.t()) :: boolean
  defp is_all_lower?(string) do
    string == String.downcase(string)
  end

  @spec split_into_words(String.t()) :: [ String.t() ]
  defp split_into_words(string) do
    String.split(string, ~r{\W}, trim: true)
  end

end
