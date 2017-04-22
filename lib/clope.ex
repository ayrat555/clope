defmodule Clope do
  alias Clope.Algorithm
  alias Clope.Utils

  def cluster(transactions, repulsion)
      when is_list(transactions)
      when is_number(repulsion) do
    transactions
    |> Utils.prepare_transactions
    |> Algorithm.clusters(repulsion)
    |> Utils.externalize_partition
  end
end
