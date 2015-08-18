defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(Dict.t) :: map()
  def transform(input) do
    input
    |> Enum.reduce(%{}, fn {letter, list}, map ->
      list
      |> Enum.reduce(map, fn word, acc ->
        Dict.put(acc, String.downcase(word), letter)
      end)
    end)
  end
end
