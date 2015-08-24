defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    Agent.start_link(fn -> %{balance: 0} end, name: __MODULE__)
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(_account) do
    Agent.stop(__MODULE__)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(_account) do
    Agent.get(__MODULE__, fn map -> map.balance end)
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(_account, amount) do
    Agent.update(__MODULE__, fn map ->
      balance = map.balance
      %{map | balance: balance + amount}
    end)
  end
end
