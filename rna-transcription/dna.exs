defmodule DNA do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> DNA.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    lookup_table = %{
      ?G => ?C,
      ?C => ?G,
      ?T => ?A,
      ?A => ?U,
    }
    dna
    |> Enum.map(fn char -> lookup_table[char] end)
  end
end
