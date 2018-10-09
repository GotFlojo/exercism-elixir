defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    no_letters_nums_dashes = ~r/[^\p{L}|\p{N}|\p{Pd}]/u
    sentence
    |> String.split(no_letters_nums_dashes, trim: true)
    |> Enum.reduce(%{}, &(add_word_to_histogram(&2, String.downcase(&1))))
  end

  @spec add_word_to_histogram(map, String.t()) :: map
  defp add_word_to_histogram(wordlist, word) do
    Map.update(wordlist, word, 1, &(&1 + 1))
  end
end
