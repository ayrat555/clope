defmodule Clope.Algorithm do
  alias Clope.Profit
  alias Clope.Cluster
  alias Clope.Partition

  def initialize_clusters(transactions, repulsion) do
    partition = %Partition{}

    transactions
    |> Enum.reduce(partition, fn(transaction, clusters) ->
      transaction |> add_to_partition(clusters, repulsion)
    end)
  end

  def add_to_partition(
      transaction,
      %Partition{clusters: clusters} = partition,
      repulsion) do
    new_cluster_delta = Profit.delta(%Cluster{}, transaction, repulsion)
    new_cluster = Cluster.add_transaction(%Cluster{}, transaction)

    {best_delta, best_cluster} =
      clusters
      |> Enum.reduce({new_cluster_delta, nil}, fn(cluster, {best_delta, best_cluster}) ->
        delta = Profit.delta(cluster, transaction, repulsion)
        if best_delta < delta do
          {delta, cluster}
        else
          {best_delta, best_cluster}
        end
      end)

    case {best_delta, best_cluster} do
      {^new_cluster_delta, nil} ->
        Partition.add_cluster(partition, new_cluster)
      {delta, cluster} ->
        new_cluster = Cluster.add_transaction(cluster, transaction)
        Partition.replace_cluster(partition, cluster, new_cluster)
    end
  end
end
