defmodule Clope do
  alias Clope.Algorithm
  alias Clope.Utils

  @doc """
  Clusterize transactions with a given repulsion parameter.

  """
  def clusterize(transactions, repulsion)
      when is_list(transactions)
      when is_number(repulsion) do
    transactions
    |> Utils.internalize_transactions
    |> Algorithm.clusterize(repulsion)
    |> Utils.externalize_partition
  end
end
