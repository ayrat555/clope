defmodule Clope.TransactionTest do
  use ExUnit.Case
  alias Clope.Transaction
  alias Clope.Object

  @transaction %Transaction{
    name: "transaction",
    objects: [
      %Object{value: "object1"},
      %Object{value: "object10"},
      %Object{value: "object100"}
    ]
  }

  test "calculates transaction stats" do
    stats = @transaction |> Transaction.object_stats
    %Transaction{objects: objects} = @transaction

    objects
    |> Enum.each(fn(%Object{value: value}) ->
      %{^value => 1} = stats
    end)
  end
end
