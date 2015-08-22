defmodule Allergies do
  @names ["cats", "pollen", "chocolate", "tomatoes", "strawberries",
         "shellfish", "peanuts", "eggs"]
  @doc """
  List the allergies for which the corresponding flag bit is true.

  Allergies should be ordered, starting with the allergie with the least
  significant bit ("eggs").
  """
  @spec list(non_neg_integer) :: [String.t]
  def list(flags) do
    flags
    |> find_bits
    |> Stream.zip(@names)
    |> Stream.filter(fn {flag, _name} -> flag == 1 end)
    |> Stream.map(fn {_flag, name} -> name end)
    |> Enum.into(HashSet.new)
  end

  def find_bits(flags) do
    bits = to_binary(flags, [])
    if length(bits) <= 8 do
      pad_left(8 - length(bits), bits)
    else
      remove_left(length(bits) - 8, bits)
    end
  end

  defp pad_left(0, lst), do: lst
  defp pad_left(number, lst), do: pad_left(number - 1, [0 | lst])

  defp remove_left(0, lst), do: lst
  defp remove_left(number, [_head | tail]), do: remove_left(number - 1, tail)

  defp to_binary(0, bits), do: bits
  defp to_binary(number, bits) do
    d = div(number, 2)
    r = rem(number, 2)
    to_binary(d, [r | bits])
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t) :: boolean
  def allergic_to?(flags, item) do
    bits = find_bits(flags)
    idx = Enum.find_index(@names, fn name -> name == item end)
    Enum.at(bits, idx) == 1
  end
end
