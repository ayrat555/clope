defmodule Clope.Algorithm do
  alias Clope.Profit
  alias Clope.Struct.Cluster
  alias Clope.Struct.Partition
  @moduledoc false

  def clusterize(transactions, repulsion) do
    transactions
    |> initialize_partition(repulsion)
    |> optimize_partition(transactions, repulsion)
  end

  def initialize_partition(transactions, repulsion) do
    transactions
    |> Enum.reduce(%Partition{}, fn transaction, partition ->
      transaction |> add_to_partition(partition, repulsion)
    end)
  end

  def optimize_partition(partition, transactions, repulsion) do
    optimized_partition = optimize_partition(partition, transactions, repulsion, true)

    optimized_partition |> remove_empty_clusters
  end

  defp optimize_partition(partition, _transactions, _repulstion, false) do
    partition
  end

  defp optimize_partition(partition, transactions, repulsion, optimized) do
    {optimized_partition, optimized} =
      optimize_transactions(partition, transactions, repulsion, optimized)

    optimize_partition(optimized_partition, transactions, repulsion, optimized)
  end

  defp optimize_transactions(partition, [transaction | []], repulsion, optimized) do
    {optimized_partition, optimized} =
      transaction
      |> reposition_in_partition(partition, repulsion, optimized)

    {optimized_partition, optimized}
  end

  defp optimize_transactions(partition, [transaction | tail], repulsion, optimized) do
    {optimized_partition, optimized} =
      transaction
      |> reposition_in_partition(partition, repulsion, optimized)

    optimize_transactions(optimized_partition, tail, repulsion, optimized)
  end

  defp reposition_in_partition(transaction, partition, repulsion, optimized) do
    old_cluster = Partition.find_cluster(partition, transaction)
    new_cluster = Cluster.remove_transaction(old_cluster, transaction)
    new_partition = Partition.replace_cluster(partition, old_cluster, new_cluster)

    optimized_partition = add_to_partition(transaction, new_partition, repulsion)

    optimized =
      if optimized do
        optimized_cluster = Partition.find_cluster(optimized_partition, transaction)

        !Cluster.equal?(old_cluster, optimized_cluster)
      else
        optimized
      end

    {optimized_partition, optimized}
  end

  defp remove_empty_clusters(%Partition{clusters: clusters}) do
    clusters =
      clusters
      |> Enum.filter(fn %Cluster{transaction_count: count} ->
        count != 0
      end)

    %Partition{clusters: clusters}
  end

  defp add_to_partition(
         transaction,
         %Partition{clusters: clusters} = partition,
         repulsion
       ) do
    clusters
    |> max_profit_cluster(transaction, repulsion)
    |> add_to_cluster(partition, transaction)
  end

  defp add_to_cluster(cluster, partition, transaction) do
    new_cluster = Cluster.add_transaction(cluster, transaction)

    Partition.replace_cluster(partition, cluster, new_cluster)
  end

  defp max_profit_cluster(clusters, transaction, repulsion) do
    empty_cluster = Cluster.new()
    empty_cluster_delta = Profit.delta(empty_cluster, transaction, repulsion)

    {_, found_best_cluster} =
      clusters
      |> Enum.map(fn cluster ->
        delta = Profit.delta(cluster, transaction, repulsion)

        {delta, cluster}
      end)
      |> Enum.reduce(
        {empty_cluster_delta, empty_cluster},
        fn {current_delta, current_cluster}, {best_delta, best_cluster} ->
          if best_delta <= current_delta do
            {current_delta, current_cluster}
          else
            {best_delta, best_cluster}
          end
        end
      )

    found_best_cluster
  end
end
