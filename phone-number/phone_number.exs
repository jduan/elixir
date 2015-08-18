defmodule Phone do
  @invalid_number "0000000000"

  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    raw
    |> String.split("")
    |> Enum.filter(fn char -> Regex.match?(~r/\d/, char) end)
    |> List.to_string
    |> valid_number?
    |> strip_leading_1
  end

  defp strip_leading_1(nil), do: @invalid_number

  defp strip_leading_1(numbers) do
    if String.length(numbers) == 11 do
      if String.at(numbers, 0) == "1" do
        String.slice(numbers, 1, 10)
      else
        @invalid_number
      end
    else
      numbers
    end
  end

  defp valid_number?(numbers) do
    if String.length(numbers) in [10,11] do
      numbers
    else
      nil
    end
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    raw
    |> number
    |> String.slice(0, 3)
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    raw
    |> number
    |> do_pretty
  end

  defp do_pretty(numbers) do
    area = String.slice(numbers, 0, 3)
    part2 = String.slice(numbers, 3, 3)
    part3 = String.slice(numbers, 6, 4)
    "(#{area}) #{part2}-#{part3}"
  end
end
