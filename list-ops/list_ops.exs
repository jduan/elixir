defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do
    do_count(l)
  end

  defp do_count([]), do: 0
  defp do_count([_head|tail]), do: 1 + do_count(tail)

  @spec reverse(list) :: list
  def reverse(l) do
    do_reverse(l, [])
  end

  defp do_reverse([], reversed), do: reversed
  defp do_reverse([head|tail], reversed) do
    do_reverse(tail, [head | reversed])
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    do_map(l, f, [])
  end

  defp do_map([], _f, mapped), do: reverse(mapped)
  defp do_map([head|tail], f, mapped) do
    do_map(tail, f, [f.(head) | mapped])
  end


  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    do_filter(l, f, [])
  end

  defp do_filter([], _f, filtered), do: reverse(filtered)
  defp do_filter([head|tail], f, filtered) do
    if f.(head) do
      do_filter(tail, f, [head | filtered])
    else
      do_filter(tail, f, filtered)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce(l, acc, f) do
    do_reduce(l, acc, f)
  end

  defp do_reduce([], acc, _f), do: acc
  defp do_reduce([head | tail], acc, f) do
    do_reduce(tail, f.(head, acc), f)
  end

  @spec append(list, list) :: list
  def append(a, b) do
    do_append(reverse(a), b)
  end

  defp do_append([], b), do: b
  defp do_append([head | tail], b) do
    do_append(tail, [head | b])
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    do_concat(ll, [])
  end

  defp do_concat([], flat_list), do: reverse flat_list
  defp do_concat([lst | tail], flat_list) do
    do_concat(tail, append(reverse(lst), flat_list))
  end
end
