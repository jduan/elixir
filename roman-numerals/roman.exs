defmodule Roman do
  @lookup %{
    1 => "I",
    10 => "X",
    100 => "C",
    4 => "IV",
    40 => "XL",
    400 => "CD",
    5 => "V",
    50 => "L",
    500 => "D",
    9 => "IX",
    90 => "XC",
    900 => "CM",
    1000 => "M",
  }
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number) do
    keys = @lookup
    |> Dict.keys
    |> Enum.sort(&(&1 > &2))

    build_numerals(keys, number, [])
    |> Enum.reverse
    |> Enum.join("")
  end

  defp build_numerals(_keys, 0, numerals) do
    numerals
  end

  defp build_numerals(keys, number, numerals) do
    largest = find_largest(keys, number)
    build_numerals(keys, number - largest, [@lookup[largest] | numerals])
  end

  defp find_largest(keys, number) do
    keys
    |> Enum.find(fn key -> key <= number end)
  end
end
