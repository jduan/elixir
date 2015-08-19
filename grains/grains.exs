defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number) do
    do_square(number)
  end

  def do_square(1), do: 1
  def do_square(number), do: 2 * do_square(number - 1)

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    1..64
    |> Enum.map(fn x -> square(x) end)
    |> Enum.sum
  end
end
