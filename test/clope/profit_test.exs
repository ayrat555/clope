defmodule Clope.ProfitTest do
  use ExUnit.Case
  alias Clope.Profit
  alias Clope.TestHelper

  @partition TestHelper.create(:partition,
    [
      [
        {"transaction1", ["a", "b", "c"]},
        {"transaction2", ["a", "c"]}
      ],
      [
        {"transaction3", ["b"]}
      ]
    ]
  )
  @repulsion 2


  test "calculates profit function value" do
    profit = Profit.value(@partition, @repulsion)
    expected_profit = (3 * 5 / 3 / 9 * 2 + 1) / 3

    assert profit == expected_profit
  end
end
