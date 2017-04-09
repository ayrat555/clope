defmodule Clope.ClusterTest do
  use ExUnit.Case
  alias Clope.Cluster
  @cluster [
    {"transaction1", ["object1", "object2", "object5"]},
    {"transaction2", ["object1", "object5"]}
  ]

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
