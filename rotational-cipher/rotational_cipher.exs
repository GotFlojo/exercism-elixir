defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, 0), do: text
  def rotate(text, shift) do
    text
    |> String.to_charlist
    |> Enum.map(&(shift_letter(&1, shift)))
    |> Kernel.to_string
  end

  defp shift_letter(t, shift) do
    cond do
      t in ?a..?z -> shift_letter(t, shift, ?a, ?z)
      t in ?A..?Z -> shift_letter(t, shift, ?A, ?Z)
      true        -> t
    end
  end

  defp shift_letter(t, shift, low_bound, high_bound) when shift > (high_bound - t) do
    (low_bound - 1) + rem((t+shift), high_bound)
  end
  defp shift_letter(t, shift, _, _), do: t+shift
end
