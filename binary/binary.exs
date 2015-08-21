defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string) do
    do_to_decimal(string, 0)
  end

  defp do_to_decimal("", acc), do: acc

  defp do_to_decimal(<<49, rest::binary>>, acc) do
    # 49 is "1"
    do_to_decimal(rest, acc * 2 + 1)
  end

  defp do_to_decimal(<<48, rest::binary>>, acc) do
    # 48 is "0"
    do_to_decimal(rest, acc * 2 + 0)
  end

  defp do_to_decimal(_, _acc), do: 0

end
