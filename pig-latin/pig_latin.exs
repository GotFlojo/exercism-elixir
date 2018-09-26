defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do 
    phrase
    |> String.split(" ", trim: true)
    |> Enum.map(&translate_string/1)
    |> Enum.join(" ")
  end


  defp translate_string(phrase=<<"x", second::utf8,tail::binary>>) do
    if String.match?(<<second>>, ~r{^[aeiou]}) do
      <<second>> <> tail <> "x" <> "ay"
    else
      phrase <> "ay"
    end
  end
  defp translate_string(phrase=<<"y", second::utf8,tail::binary>>) do
    if String.match?(<<second>>, ~r{^[aeiou]}) do
      <<second>> <> tail <> "y" <> "ay"
    else
      phrase <> "ay"
    end
  end
  defp translate_string(<<"ch", tail::binary>>) do
    translate_string(tail <> "ch")
  end
  defp translate_string(<<"qu", tail::binary>>) do
    translate_string(tail <> "qu")
  end
  defp translate_string(<<"th", tail::binary>>) do
    translate_string(tail <> "th")
  end
  defp translate_string(<<"sch", tail::binary>>) do
    translate_string(tail <> "sch")
  end
  defp translate_string(<<"squ", tail::binary>>) do
    translate_string(tail <> "squ")
  end
  defp translate_string(<<"thr", tail::binary>>) do
    translate_string(tail <> "thr")
  end
  defp translate_string(phrase=<<first, tail::binary>>) do 
    if String.match?(phrase, ~r{^[aeiou].*}) do
      phrase <> "ay"
    else
      translate_string(tail <> <<first>>)
    end
  end
end
