defmodule Series do

  @doc """
  Splits up the given string of numbers into an array of integers.
  """
  @spec digits(String.t) :: [non_neg_integer]
  def digits(number_string) do
    number_string
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  @doc """
  Generates sublists of a given size from a given string of numbers.
  """
  @spec slices(String.t, non_neg_integer) :: [list(non_neg_integer)]
  def slices(number_string, size) do
    number_string
    |> digits
    |> chunk(size)
  end

  defp chunk([], _size), do: [[]]
  defp chunk(digits, size), do: Enum.chunk(digits, size, 1)

  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t, non_neg_integer) :: non_neg_integer
  def largest_product(number_string, size) do
    number_string
    |> slices(size)
    |> Enum.map(&product/1)
    |> Enum.max
  end

  defp product(digits) do
    digits
    |> Enum.reduce(1, &(&1 * &2))
  end
end