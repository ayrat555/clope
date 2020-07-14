defmodule Clope do
  alias Clope.Algorithm
  alias Clope.Utils

  @moduledoc """
  CLOPE: a fast and effective clustering algorithm for transactional data.
  """

  @doc """
  Clusterize transactions with a given repulsion parameter.

      iex> input = [
        {"transaction1", ["object1", "object2", "object3"]},
        {"transaction2", ["object1", "object5"]},
        {"transaction3", ["object2", "object3"]},
        {"transaction4", ["object1", "object5"]}
      ]
      iex> result = input |> Clope.clusterize(2)
      [
        [
          {"transaction1", ["object1", "object2", "object3"]},
          {"transaction3", ["object2", "object3"]}
        ],
        [
          {"transaction2", ["object1", "object5"]},
          {"transaction4", ["object1", "object5"]}
        ]
      ]
  """
  def clusterize(transactions, repulsion)
      when is_list(transactions)
      when is_number(repulsion) do
    transactions
    |> Utils.internalize_transactions()
    |> Algorithm.clusterize(repulsion)
    |> Utils.externalize_partition()
  end
end
