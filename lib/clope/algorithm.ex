defmodule Clope.Algorithm do
  alias Clope.Profit
  alias Clope.Cluster
  alias Clope.Partition

  def clusters(transactions, repulsion) do
    partition = transactions |> initialize_clusters(repulsion)

    # optimize_clusters(partition, transactions, repulstion)
  end

  def initialize_clusters(transactions, repulsion) do
    partition = %Partition{}

    transactions
    |> Enum.reduce(partition, fn(transaction, clusters) ->
      transaction |> add_to_partition(clusters, repulsion)
    end)
  end

  # def optimize_clusters(partition, transactions, repulsion) do
  #   _optimize_clusters(initial_clusters, transactions, repulsion, true)
  # end

  # defp iterate(partition, _transactions, _repulstion, false) do
  #   partition
  # end

  # defp iterate(partition, transactions, repulsion, moved) do
  #   _optimize_clusters(partition, transactions, repulsion, moved)
  # end

  # defp _optimize_clusters(partition, [transaction | tail], repulsion, moved) do
  #   old_cluster = Partition.find_cluster(partition, transaction)
  #   new_cluster = Cluster.remove_transaction(old_cluster, transaction)
  #   new_partition = Partition.replace_cluster(partition, old_cluster, new_cluster)

  #   optimized_partition = add_to_partition(transaction, new_partition, repulsion)

  #   moved = unless moved do
  #     optimized_cluster = Partition.find_cluster(optimized_cluster, transaction)
  #     optimized_cluster == old_cluster
  #   else
  #     moved
  #   end

  #   _optimize_clusters(optimized_partition, tail, repulsion, moved)
  # end

  # defp _optimize_clusters(partition, [transaction | []], repulsion, moved) do
  #   old_cluster = Partition.find_cluster(partition, transaction)
  #   new_cluster = Cluster.remove_transaction(old_cluster, transaction)
  #   new_partition = Partition.replace_cluster(partition, old_cluster, new_cluster)

  #   optimized_partition = add_to_partition(transaction, new_partition, repulsion)

  #   moved = unless moved do
  #     optimized_cluster = Partition.find_cluster(optimized_cluster, transaction)
  #     optimized_cluster == old_cluster
  #   else
  #     moved
  #   end

  #   iterate(partition, )
  # end

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
