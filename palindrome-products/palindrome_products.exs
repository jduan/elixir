defmodule Palindromes do

  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map()
  def generate(max_factor, min_factor \\ 1) do
    for x <- min_factor..max_factor, y <- x..max_factor do
      [x, y]
    end
    |> Enum.filter(fn [x, y] -> palindrome?(x * y) end)
    |> Enum.reduce(HashDict.new, fn [x, y], map ->
      product = x * y
      if Dict.has_key?(map, product) do
        lst = map[product]
        Dict.put(map, product, [[x, y] | lst])
      else
        Dict.put(map, product, [[x, y]])
      end
    end)
    |> Enum.map(fn {key, value} -> {key, Enum.reverse(value)} end)
    |> Enum.into(HashDict.new)
  end

  defp palindrome?(number) do
    to_string(number) == String.reverse(to_string(number))
  end
end
