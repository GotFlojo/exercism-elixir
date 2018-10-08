defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.split(~r/[^\p{L}|\p{N}|\p{Pd}]/u, trim: true)
    |> Enum.reduce(%{}, &(add_word_to_histogram(&2, String.downcase(&1))))
  end

  @spec add_word_to_histogram(map, String.t()) :: map
  defp add_word_to_histogram(wordlist, word) do
    case Map.fetch(wordlist, word) do
      {:ok, val} -> %{wordlist| word => val + 1}
      :error     -> Map.put(wordlist, word, 1)
    end
  end
end
