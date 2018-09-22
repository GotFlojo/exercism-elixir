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

  def capitalize([]), do: []
  def capitalize(words) do
    Enum.map(words, &capitalize_lower/1)
  end

  def capitalize_lower(string) do
    if is_all_lower?(string) do
      String.capitalize(string)
    else
      string
    end
  end

  def extract_uppercase([]), do: []
  def extract_uppercase(words) do
    Enum.flat_map(words, &(String.split(&1, ~r<\P{Lu}>, trim: true)))
  end

  def is_all_lower?(string) do
    string == String.downcase(string)
  end

  def split_into_words(string) do
    String.split(string, ~r{\W}, trim: true)
  end

end
