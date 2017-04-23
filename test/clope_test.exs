defmodule ClopeTest do
  use ExUnit.Case
  @input [
    {"transaction1", ["object1", "object2", "object3"]},
    {"transaction2", ["object1", "object5"]},
    {"transaction3", ["object2", "object3"]},
    {"transaction4", ["object1", "object5"]}
  ]

  test "clusterizes data with repulsion of 2" do
    repulsion = 2
    result =
      @input
      |> Clope.cluster(repulsion)

    [
      [
        {"transaction1", ["object1", "object2", "object3"]},
        {"transaction3", ["object2", "object3"]}
      ],
      [
        {"transaction2", ["object1", "object5"]},
        {"transaction4", ["object1", "object5"]}
      ]
    ] = result
  end

  test "clusterizes data with repulsion of 4" do
    repulsion = 4
    result =
      @input
      |> Clope.cluster(repulsion)

    [
      [
        {"transaction1", ["object1", "object2", "object3"]}
      ],
      [
        {"transaction3", ["object2", "object3"]}
      ],
      [
        {"transaction2", ["object1", "object5"]},
        {"transaction4", ["object1", "object5"]}
      ]
    ] = result
  end
end
