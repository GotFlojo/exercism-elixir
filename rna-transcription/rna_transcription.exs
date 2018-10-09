defmodule RNATranscription do
  @transcription %{?A => ?U, ?C => ?G, ?G => ?C, ?T => ?A}
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char] | {:error, String.t()}
  def to_rna(dna) do
    case Enum.reduce_while(dna, [], &valid_nucleotide/2) do
      [:error|_] -> {:error, "invalid nucleotide"}
            rna  -> Enum.reverse(rna)
    end
  end

  defp valid_nucleotide(n, acc) do
    case Map.fetch(@transcription, n) do
      {:ok, rna} -> {:cont, [rna | acc]}
      :error     -> {:halt, [:error | acc]}
    end
  end
end
