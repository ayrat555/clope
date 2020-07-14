defmodule Clope.AlgorithmTest do
  use ExUnit.Case
  import Clope.TestFactory
  alias Clope.Algorithm
  alias Clope.Struct.Partition
  alias Clope.Struct.Cluster

  test "initializes clusters" do
    transactions =
      build_list_from_string(
        :transaction,
        [
          {"transaction1", ["a", "b", "c", "d", "o", "p", "f"]},
          {"transaction2", ["a", "d"]},
          {"transaction3", ["a", "c", "e"]},
          {"transaction4", ["b", "c"]},
          {"transactions", ["e", "d"]},
          {"transaction6", ["a"]}
        ]
      )

    repulsion = 1.5

    %Partition{clusters: clusters} = transactions |> Algorithm.initialize_partition(repulsion)

    assert clusters |> Enum.count() == 4
  end

  test "optimizes partition" do
    transactions =
      build_list_from_string(
        :transaction,
        [
          {"transaction1", ["a", "b", "c", "d", "o", "p", "f"]},
          {"transaction2", ["a", "d"]},
          {"transaction3", ["a", "c", "e"]},
          {"transaction4", ["b", "c"]},
          {"transactions", ["e", "d"]},
          {"transaction6", ["a"]}
        ]
      )

    partition =
      build_from_string(
        :partition,
        [
          [
            {"transaction1", ["a", "b", "c", "d", "o", "p", "f"]},
            {"transaction2", ["a", "d"]},
            {"transaction3", ["a", "c", "e"]}
          ],
          [
            {"transaction4", ["b", "c"]},
            {"transactions", ["e", "d"]},
            {"transaction6", ["a"]}
          ]
        ]
      )

    repulsion = 1.5

    %Partition{clusters: clusters} =
      partition
      |> Algorithm.optimize_partition(transactions, repulsion)

    assert clusters |> Enum.count() == 2

    %Cluster{transactions: transactions} = clusters |> Enum.at(0)
    assert transactions |> Enum.count() == 1

    assert transactions |> Enum.at(0) ==
             build_from_string(
               :transaction,
               {"transaction1", ["a", "b", "c", "d", "o", "p", "f"]}
             )
  end
end
