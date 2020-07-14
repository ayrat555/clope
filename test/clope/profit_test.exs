defmodule Clope.ProfitTest do
  use ExUnit.Case
  import Clope.TestFactory
  alias Clope.Profit

  test "calculates delta value of profit" do
    cluster =
      build_from_string(
        :cluster,
        [
          {"transaction1", ["a", "b", "d"]},
          {"transaction2", ["a", "c"]}
        ]
      )

    transaction = build_from_string(:transaction, {"transaction3", ["a", "d"]})
    repulsion = 3

    delta = Profit.delta(cluster, transaction, repulsion)
    expected_delta = 7 * 3 / 64 - 5 * 2 / 64

    assert delta == expected_delta
  end
end
