defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    len_a = length(a)
    len_b = length(b)
    cond do
      do_compare(a, b) ->
        cond do
          len_a == len_b -> :equal
          true -> :sublist
        end
      do_compare(b, a) ->
        cond do
          len_a == len_b -> :equal
          true -> :superlist
        end
      true -> :unequal
    end
  end

  def do_compare([], []), do: true

  def do_compare(a, [_head | tail] = b) when length(a) <= length(b) do
    sublist?(a, b) or do_compare(a, tail)
  end

  def do_compare(_a, _b), do: false

  def sublist?([], _b) do
    true
  end
  def sublist?([head1 | tail1], [head2 | tail2]) do
    head1 === head2 and sublist?(tail1, tail2)
  end
end
