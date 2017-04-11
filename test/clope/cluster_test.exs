defmodule Clope.ClusterTest do
  use ExUnit.Case
  alias Clope.Cluster
  alias Clope.TestHelper

  @cluster TestHelper.create(:cluster,
    [
      {"transaction1", ["a", "c", "d"]},
      {"transaction2", ["d", "e"]},
      {"transaction3", ["d", "e", "f"]}
    ]
  )

  test "returns number of transactions" do
    result = @cluster |> Cluster.number_of_transactions

    assert result == 3
  end

  test "calculates cluster stats" do
    result = @cluster |> Cluster.item_stats

    %{"d" => 3} = result
    %{"e" => 2} = result
    %{"a" => 1} = result
    %{"c" => 1} = result
    %{"f" => 1} = result
  end

  test "calculates cluster attributes" do
    result = @cluster |> Cluster.attributes

    { 8/5, 5 } = result
  end
end
