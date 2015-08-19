defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({pos_integer, pos_integer, pos_integer}) :: :calendar.date

  def from({year, month, day}) do
    days = div(1_000_000_000, 24 * 60 * 60)
    do_from({year, month, day}, days)
  end

  defp do_from({year, month, day}, 0) do
    {year, month, day}
  end

  defp do_from({year, month, day}, days) do
    new_tuple = cond do
      month == 2 ->
	days_of_month = if Year.leap_year?(year), do: 29, else: 28
	do_from_days(year, month, day, days_of_month)
      month in [1,3,5,7,8,10,12] ->
	do_from_days(year, month, day, 31)
      true ->
	do_from_days(year, month, day, 30)
    end

    do_from(new_tuple, days - 1)
  end

  defp do_from_days(year, month, day, days_of_month) do
    if day < days_of_month do
      {year, month, day + 1}
    else
      if month < 12 do
	{year, month + 1, 1}
      else
	{year + 1, 1, 1}
      end
    end
  end
end

defmodule Year do
  @doc """
  Returns whether 'year' is a leap year.

  A leap year occurs:

  on every year that is evenly divisible by 4
  except every year that is evenly divisible by 100
  except every year that is evenly divisible by 400.
  """
  @spec leap_year?(non_neg_integer) :: boolean
  def leap_year?(year) do
    if rem(year, 4) != 0 do
      false
    else
      if rem(year, 100) == 0 do
	if rem(year, 400) == 0 do
	  true
	else
	  false
	end
      else
	true
      end
    end
  end
end