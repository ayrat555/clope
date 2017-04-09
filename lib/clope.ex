defmodule Clope do
  alias Clope.Algorithm

  def cluster(transactions, repulsion)
      when is_list(transactions)
      when is_number(repulsion) do
    Algorithm.clusters(transactions, repulsion)
  end
end
