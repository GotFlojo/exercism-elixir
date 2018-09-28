defmodule SecretHandshake do
  use Bitwise
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  #def commands(1), do: ["wink"]
  def commands(code) do
    []
    |> mask_jump(code)
    |> mask_eyes(code)
    |> mask_blink(code)
    |> mask_wink(code)
    |> mask_reverse(code)
  end

  defp mask_wink(lst, code) do
    if band(code, 0b01) == 0,  do: lst, else: ["wink"|lst]
  end

  defp mask_blink(lst, code) do
    if band(code, 0b10) == 0,  do: lst, else: ["double blink"|lst]
  end

  defp mask_eyes(lst, code) do
    if band(code, 0b100) == 0,  do: lst, else: ["close your eyes"|lst]
  end

  defp mask_jump(lst, code) do
    if band(code, 0b1000) == 0,  do: lst, else: ["jump"|lst]
  end

  defp mask_reverse(lst, code) do
    if band(code, 0b10000) == 0,  do: lst, else: Enum.reverse(lst)
  end
end
