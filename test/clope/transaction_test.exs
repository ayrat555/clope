defmodule Clope.TransactionTest do
  use ExUnit.Case
  alias Clope.Transaction
  alias Clope.TestHelper
  alias Clope.Item

  @transaction TestHelper.create(:transaction, ["a", "b", "c"])

  test "calculates transaction stats" do
    stats = @transaction |> Transaction.item_stats
    %Transaction{items: items} = @transaction

    items
    |> Enum.each(fn(%Item{value: value}) ->
      %{^value => 1} = stats
    end)
  end
end
