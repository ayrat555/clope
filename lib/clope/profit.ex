defmodule Clope.Profit do
  alias Clope.Cluster

  def value(clusters, repulsion) do
    numerator = 0
    denominator = 0
    accumulator = {numerator, denominator, repulsion}

    {numerator, denominator, _repulsion} = clusters
      |> Enum.reduce(accumulator, &reduce_function/2)

    numerator / denominator
  end

  defp reduce_function(cluster, {numerator, denominator, repulsion}) do
    {height, width} = cluster |> Cluster.attributes
    transaction_count = cluster |> Cluster.number_of_transactions
    iteration_value = height * width / :math.pow(width, repulsion) * transaction_count

    {numerator + iteration_value, denominator + transaction_count, repulsion}
  end
end
