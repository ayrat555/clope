defmodule Clope.Algorithm do
  alias Clope.Profit
  alias Clope.Cluster
  alias Clope.Partition

  def clusters(transactions, repulsion) do
    initial_clusters = transactions |> initialize_clusters(repulsion)


  end

  def initialize_clusters(transactions, repulsion) do
    partition = %Partition{}

    transactions
    |> Enum.reduce(partition, fn(transaction, clusters) ->
      transaction |> add_to_partition(clusters, repulsion)
    end)
  end

  defp add_to_partition(
      transaction,
      %Partition{clusters: clusters} = partition,
      repulsion) do

    clusters
    |> max_profit_cluster(transaction, repulsion)
    |> add_to_cluster(partition, transaction)
  end

  defp add_to_cluster({_delta, nil}, partition, transaction) do
    new_cluster = Cluster.add_transaction(%Cluster{}, transaction)

    Partition.add_cluster(partition, new_cluster)
  end

  defp add_to_cluster({_delta, cluster}, partition, transaction) do
    new_cluster = Cluster.add_transaction(cluster, transaction)

    Partition.replace_cluster(partition, cluster, new_cluster)
  end

  defp max_profit_cluster(clusters, transaction, repulsion) do
    new_cluster_delta = Profit.delta(%Cluster{}, transaction, repulsion)

    max_profit_cluster(clusters, {new_cluster_delta, nil}, transaction, repulsion)
  end

  defp max_profit_cluster([], {best_delta, best_cluster}, _transaction, _repulsion) do
    {best_delta, best_cluster}
  end

  defp max_profit_cluster([cluster | []], {best_delta, best_cluster}, transaction, repulsion) do
    delta = cluster |> Profit.delta(transaction, repulsion)

    if best_delta < delta,
      do: {delta, cluster},
      else: {best_delta, best_cluster}
  end

  defp max_profit_cluster([cluster | tail], {best_delta, best_cluster}, transaction, repulsion) do
    delta = cluster |> Profit.delta(transaction, repulsion)

    {best_delta, best_cluster} =
      if best_delta < delta,
        do: {delta, cluster},
        else: {best_delta, best_cluster}

    max_profit_cluster(tail, {best_delta, best_cluster}, transaction, repulsion)
  end
end
