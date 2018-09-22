defmodule Bob do
  def hey(input) do
    cond do
      silence?(input)                     -> "Fine. Be that way!"
      asking_in_capitals?(input)          -> "Calm down, I know what I'm doing!"
      String.ends_with?(input, "?")       -> "Sure."
      not_numbers_and_uppercase?(input)   -> "Whoa, chill out!"
      true                                -> "Whatever."
    end
  end

  defp asking_in_capitals?(string) do
    not_numbers_and_uppercase?(string) && String.ends_with?(string , "?")
  end

  defp is_all_uppercase?(string), do: string == String.upcase(string)

  defp is_all_numbers?(string), do: String.match?(string, ~r{^\W*(\d+\W*)+$})
  # Maybe this is clearer? I dunno
  # defp is_all_numbers?(string) do
    # string
    # |> String.split(~r{\W}, trim: true)
    # |> Enum.all?(&(String.match?(&1, ~r{^\d+$})))
  # end

  defp not_numbers_and_uppercase?(string) do
    (not is_all_numbers?(string)) and is_all_uppercase?(string)
  end

  defp silence?(string) do
    String.match?(string, ~r{^\s*$})
  end
end
