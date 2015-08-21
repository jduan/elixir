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
