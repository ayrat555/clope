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
      |> Clope.clusterize(repulsion)

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
      |> Clope.clusterize(repulsion)

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

  test 'clusterizes data even when initial data can not be divided into clusters' do
    repulsion = 2
    # Rita's and Sveta's example
    transactions = [
      {"vinegret", ["svekla", "kolbasa", "goroh"]},
      {"olivya", ["kartoshka", "goroh"]},
      {"memoza", ["eggs", "svekla"]},
      {"salat", ["kolbasa", "kukuruza"]}
    ]

    result = transactions |> Clope.clusterize(repulsion)

    assert Enum.count(result) == 4
  end
end
