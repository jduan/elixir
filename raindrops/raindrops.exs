defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    primes = Sieve.primes_to(number)
    find_factors(number, primes, [])
    |> Enum.filter(fn factor -> factor in [3, 5, 7] end)
    |> factors_to_string(number)
  end

  defp factors_to_string([], number), do: to_string number
  defp factors_to_string(factors, _number) do
    factors
    |> Enum.uniq
    |> Enum.map(&factor_to_string/1)
    |> Enum.join("")
  end

  defp factor_to_string(3), do: "Pling"
  defp factor_to_string(5), do: "Plang"
  defp factor_to_string(7), do: "Plong"

  defp find_factors(1, _primes, factors), do: Enum.reverse factors

  defp find_factors(number, primes, factors) do
    factor = primes
    |> Enum.find(fn prime -> rem(number, prime) == 0 end)
    find_factors(div(number, factor), primes, [factor | factors])
  end
end

defmodule Sieve do

  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    primes = HashSet.new
    map = HashDict.new
    lst = 2..limit
    loop(2, limit, lst, map, primes)
    |> Enum.sort
  end

  def loop(nil, _limit, _lst, _map, primes) do
    primes
  end

  def loop(unmarked, limit, lst, map, primes) do
    primes = Set.put(primes, unmarked)
    map = mark_multiples(limit, unmarked, map)
    unmarked = find_first_unmarked(lst, map, primes)
    loop(unmarked, limit, lst, map, primes)
  end

  defp mark_multiples(limit, number, map) do
    1..div(limit, number)
    |> Enum.reduce(map, fn times, acc ->
      Dict.put(acc, number * times, 1)
    end)
  end

  defp find_first_unmarked(lst, map, primes) do
    lst
    |> Enum.find(nil, fn n ->
      is_nil(Dict.get(map, n)) and not n in primes
    end)
  end

end
