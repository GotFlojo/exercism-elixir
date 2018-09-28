defmodule TwelveDays do

  @gifts ["a Partridge in a Pear Tree", 
          "two Turtle Doves",
          "three French Hens",
          "four Calling Birds",
          "five Gold Rings",
          "six Geese-a-Laying",
          "seven Swans-a-Swimming",
          "eight Maids-a-Milking",
          "nine Ladies Dancing",
          "ten Lords-a-Leaping",
          "eleven Pipers Piping",
          "twelve Drummers Drumming"]
  @number_words ["first", "second", "third", "fourth", "fifth", "sixth", 
                 "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth"]

  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    "On the #{number_to_word(number)} day of Christmas my true love gave to me, #{presents(number)}."
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) when starting_verse < ending_verse do
    days= 1+ starting_verse..ending_verse
    Enum.reduce(days, verse(starting_verse), fn n, verses ->
      verses <> "\n" <> verse(n) end)
  end
  def verses(starting_verse, ending_verse), do: verse(starting_verse)

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end

  defp number_to_word(number), do: Enum.at(@number_words, number-1)

  defp presents(1), do: Enum.take(@gifts, 1)
  defp presents(n) do
    presents = [last|rest] = Enum.take(@gifts, n)
    rest
    |> Enum.reverse
    |> Enum.join(", ")
    |> Kernel.<>(", and ")
    |> Kernel.<>(last)
  end
end
