defmodule ProteinTranslation do

  @translation_table %{"UGU" => "Cysteine",
                       "UGC" => "Cysteine",
                       "UUA" => "Leucine",
                       "UUG" => "Leucine",
                       "AUG" => "Methionine",
                       "UUU" => "Phenylalanine",
                       "UUC" => "Phenylalanine",
                       "UCU" => "Serine",
                       "UCC" => "Serine",
                       "UCA" => "Serine",
                       "UCG" => "Serine",
                       "UGG" => "Tryptophan",
                       "UAU" => "Tyrosine",
                       "UAC" => "Tyrosine",
                       "UAA" => "STOP",
                       "UAG" => "STOP",
                       "UGA" => "STOP"}
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    proteins = rna
              |> String.graphemes()
              |> Enum.chunk_every(3, 3, [])
              |> Enum.reduce_while([], &(build_protein(&1, &2)))
    case proteins do
      []              -> {:error, "invalid RNA"}
      [{:error} | _]  -> {:error, "invalid RNA"}
            _         -> {:ok, Enum.reverse(proteins)}
    end
  end

  defp bases_to_codons([b1, b2, b3]), do: {:ok, b1<>b2<>b3}
  defp bases_to_codons([_head|_tail]), do: {:error, "invalid RNA"}

  def build_protein(item, acc) do
    with {:ok, rna}   <- bases_to_codons(item),
       {:ok, protein} <- of_codon(rna)
    do
      case protein do 
        "STOP" -> {:halt, acc}
            _  -> {:cont, [protein | acc]}
      end
    else
      {:error, _} -> {:halt, [{:error}|acc]}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    case Map.fetch(@translation_table, codon) do
      {:ok, protein}  -> {:ok, protein}
      :error          -> {:error, "invalid codon"}
    end
  end
end
