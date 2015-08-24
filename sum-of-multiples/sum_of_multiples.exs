defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.

  The default factors are 3 and 5.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors \\ [3, 5]) do
    factors
    |> Enum.reduce(HashSet.new, fn factor, multiples ->
      find_multiples(factor, limit)
      |> Enum.into(multiples)
    end)
    |> Enum.to_list
    |> Enum.sum
  end

  defp find_multiples(factor, limit) when limit < factor do
    []
  end

  defp find_multiples(factor, limit) do
    for n <- 1..div(limit, factor) do
      factor * n
    end
  end
end
