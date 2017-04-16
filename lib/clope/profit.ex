defmodule Clope.Profit do
  alias Clope.Partition
  alias Clope.Cluster
  alias Clope.Transaction
  alias Clope.Item

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

  def delta(
    %Cluster{transaction_count: 0} = cluster,
    %Transaction{} = transaction,
    repulsion) do

    {
      new_width,
      new_item_count,
      new_transaction_count
    } = calculate_new_stats(cluster, transaction)

    profit_numerator(new_item_count, new_transaction_count, new_width, repulsion)
  end

  def delta(
      %Cluster{
        transaction_count: transaction_count,
        item_count: item_count,
        width: width
      } = cluster,
      %Transaction{} = transaction,
      repulsion) do

    {
      new_width,
      new_item_count,
      new_transaction_count
    } = calculate_new_stats(cluster, transaction)

    old_profit_numerator =
      profit_numerator(item_count, transaction_count, width, repulsion)
    new_profit_numerator =
      profit_numerator(new_item_count, new_transaction_count, new_width, repulsion)

    new_profit_numerator - old_profit_numerator
  end

  defp calculate_new_stats(
      %Cluster{
        transaction_count: transaction_count,
        item_count: item_count,
        width: width,
        occ: occ
      },
      %Transaction{items: items}) do

    {new_width, new_item_count} =
      items
      |> Enum.reduce({width, item_count}, fn(%Item{value: value}, {new_width, new_item_count}) ->
        new_width = if Map.has_key?(occ, value), do: new_width, else: new_width + 1

        {new_width, new_item_count + 1}
      end)

    {new_width, new_item_count, transaction_count + 1}
  end

  defp profit_numerator(item_count, transaction_count, width , repulstion) do
    item_count * transaction_count / :math.pow(width, repulstion)
  end
end
