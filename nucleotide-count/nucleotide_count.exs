defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count([], _), do: 0
  def count(strand, nucleotide) do
    Enum.reduce(strand, 0, 
      fn n, cnt ->
        if n == nucleotide, do: (cnt + 1), else: cnt
      end)
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map | {:error, String.t()}
  def histogram([]),  do: empty_nukelotide_histogram(@nucleotides) 
  def histogram(strand) do
    empty_histogram = empty_nukelotide_histogram(@nucleotides)
    Enum.reduce_while(strand, empty_histogram, 
      fn nuc, hist -> 
        case Map.fetch(hist, nuc) do
          {:ok, val} -> {:cont, %{hist | nuc => val + 1}}
          :error     -> {:halt, {:error, "#{[nuc]} is not recognized as a valid nucleotide"}}
        end
      end)
  end
  # Inefficient implmentation where we iterate the whole strand again for every
  # nucleotide
  # def histogram(strand) do
    # empty_histogram = empty_nukelotide_histogram(@nucleotides)
    # Enum.reduce(@nucleotides, empty_histogram,
      # fn n, hist -> %{hist | n => count(strand, n)} end)
  # end

  @spec empty_nukelotide_histogram([char]) :: map
  defp empty_nukelotide_histogram([]), do: %{}
  defp empty_nukelotide_histogram(nucleotides) do
    for nucleotide <- nucleotides, into: %{}, do: {nucleotide, 0}
  end
end
