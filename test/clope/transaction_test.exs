defmodule Clope.TransactionTest do
  use ExUnit.Case
  alias Clope.Transaction
  alias Clope.Item

  @transaction %Transaction{
    name: "transaction",
    items: [
      %Item{value: "item1"},
      %Item{value: "item10"},
      %Item{value: "item100"}
    ]
  }

  test "calculates transaction stats" do
    stats = @transaction |> Transaction.item_stats
    %Transaction{items: items} = @transaction

    items
    |> Enum.each(fn(%Item{value: value}) ->
      %{^value => 1} = stats
    end)
  end
end
