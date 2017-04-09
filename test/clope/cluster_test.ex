defmodule Clope.ClusterTest do
  use ExUnit.Case
  alias Clope.Cluster
  @cluster [
    {"transaction1", ["object1", "object2", "object5"]},
    {"transaction2", ["object1", "object5"]}
  ]

  test "returns number of transactions" do
    result = @cluster |> Cluster.number_of_transactions

    assert result == 2
  end

  test "calculates cluster stats" do
    result = @cluster |> Cluster.object_stats

    %{"object1" => 2} = result
    %{"object2" => 1} = result
    %{"object5" => 2} = result
  end

  test "calculates cluster attributes" do
    result = @cluster |> Cluster.attributes

    { 5/3, 3 } = result
  end
end
