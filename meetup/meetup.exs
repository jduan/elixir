defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup(year, month, weekday, schedule) do
    find_days(year, month, weekday)
    |> pick_day(schedule)
    |> build_result(year, month)
  end

  defp find_days(year, month, weekday) do
    lookup_table = %{
      monday: 1,
      tuesday: 2,
      wednesday: 3,
      thursday: 4,
      friday: 5,
      saturday: 6,
      sunday: 7,
    }
    weekday_number = lookup_table[weekday]

    1..:calendar.last_day_of_the_month(year, month)
    |> Enum.filter(fn day ->
      :calendar.day_of_the_week(year, month, day) == weekday_number
    end)
  end

  defp pick_day(days, schedule) do
    lookup_table = %{
      first: 0,
      second: 1,
      third: 2,
      fourth: 3,
      last: -1,
    }
    if schedule == :teenth do
      days
      |> Enum.filter(fn day -> day in 13..19 end)
      |> List.first
    else
      Enum.at(days, lookup_table[schedule])
    end
  end

  defp build_result(day, year, month) do
    {year, month, day}
  end
end
