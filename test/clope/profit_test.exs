defmodule Clope.ProfitTest do
  use ExUnit.Case
  alias Clope.Profit
  @partition [
    [
      {"transaction1", ["object1", "object2", "object5"]},
      {"transaction2", ["object1", "object5"]}
    ],
    [
      {"transaction3", ["object2"]}
    ]
  ]
  @repulsion 2


  test "calculates profit function value" do
    profit = Profit.value(@partition, @repulsion)
    expected_profit = (3 * 5 / 3 / 9 * 2 + 1) / 3

    assert profit == expected_profit
  end
end
