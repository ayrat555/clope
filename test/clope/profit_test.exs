defmodule Clope.ProfitTest do
  use ExUnit.Case
  import Clope.TestFactory
  alias Clope.Profit

  @partition build_from_string(:partition,
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
    expected_profit = 1.4444444444444446

    assert profit == expected_profit
  end
end
