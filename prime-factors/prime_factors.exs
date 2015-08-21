defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    do_factors_for(number, [])
    |> Enum.reverse
  end

  defp do_factors_for(1, factors), do: factors

  defp do_factors_for(number, factors) do
    factor = 2..max(2, trunc(:math.sqrt(number)))
    |> Enum.find(number, fn x -> rem(number, x) == 0 end)

    do_factors_for(div(number, factor), [factor | factors])
  end
end
