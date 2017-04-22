defmodule ClopeTest do
  use ExUnit.Case
  @input [
    {"transaction1", ["object1", "object2", "object3"]},
    {"transaction2", ["object1", "object5"]},
    {"transaction3", ["object2", "object3"]},
    {"transaction4", ["object1", "object5"]}
  ]
  @repulsion 4

  test "returns clustered data" do
    @input
    |> Clope.cluster(@repulsion)
  end
end
