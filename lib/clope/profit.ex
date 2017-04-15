defmodule Clope.Profit do
  alias Clope.Cluster
  alias Clope.Partition

  def value(%Partition{clusters: clusters}, repulsion) when is_number(repulsion) do
    numerator = 0
    denominator = 0
    accumulator = {numerator, denominator, repulsion}

    {numerator, denominator, _repulsion} = clusters
      |> Enum.reduce(accumulator, &reduce_function/2)

    numerator / denominator
  end

  defp reduce_function(
      %Cluster{
        transaction_count: transaction_count,
        width: width,
        item_count: item_count
      },
      {numerator, denominator, repulsion}) do
    iteration_value = item_count * width / :math.pow(width, repulsion) * transaction_count

    {numerator + iteration_value, denominator + transaction_count, repulsion}
  end
end
