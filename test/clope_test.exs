defmodule ClopeTest do
  use ExUnit.Case
  @input [
    {"transaction1", ["object1", "object2", "object3"]},
    {"transaction2", ["object1", "object3"]},
    {"transaction3", ["object2", "object3"]},
    {"transaction4", ["object1", "object5"]}
  ]

  test "returns clustered data" do
    Clope.cluster
    |> Enum.each(fn(cluster) ->
      assert is_list(cluster)
    end)
  end
end
