defmodule Clope.TransactionTest do
  use ExUnit.Case
  alias Clope.Transaction
  @transaction {"transaction", ["object1", "object10", "object100"]}

  test "calculates transaction stats" do
    stats = @transaction |> Transaction.object_stats
    {_name, objects} = @transaction

    objects
    |> Enum.each(fn(object) ->
      %{^object => 1} = stats
    end)
  end
end
