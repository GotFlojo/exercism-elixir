defmodule Bob do
  def hey(input) do
    cond do
      silence?(input)                     -> "Fine. Be that way!"
      asking_in_capitals?(input)          -> "Calm down, I know what I'm doing!"
      asking?(input)                      -> "Sure."
      yelling?(input)                     -> "Whoa, chill out!"
      true                                -> "Whatever."
    end
  end

  defp asking?(string), do: String.ends_with?(string, "?")

  defp asking_in_capitals?(string) do
    yelling?(string) && asking?(string)
  end

  defp is_all_uppercase?(string), do: string == String.upcase(string)

  defp silence?(string) do
    String.match?(string, ~r{^\s*$})
  end

  # At least one uppercase letter and all letters are uppercase
  defp yelling?(string) do
    String.match?(string, ~r/.*\p{Lu}+.*/) && is_all_uppercase?(string)
  end
end


