defmodule Clope.AlgorithmTest do
  use ExUnit.Case
  import Clope.TestFactory
  alias Clope.Algorithm
  alias Clope.Partition

  test "initializes clusters" do
    transactions = build_list_from_string(:transaction,
      [
        {"transaction2", ["a", "d"]},
        {"transaction3", ["a", "c", "e"]},
        {"transaction4", ["b", "c"]},
        {"transactions", ["e", "d"]},
        {"transaction1", ["a", "b", "c", "d", "o", "p", "f"]},
        {"transaction6", ["a"]}
      ])
    repulsion = 1.5

    %Partition{clusters: clusters} = transactions |> Algorithm.initialize_clusters(repulsion)

    assert clusters |> Enum.count == 4
  end
end
