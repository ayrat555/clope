defmodule Clope.Struct.Partition do
  defstruct clusters: []
  alias Clope.Struct.Partition
  alias Clope.Struct.Cluster
  alias Clope.Struct.Transaction

  def partition(clusters) when is_list(clusters) do
    %Partition{clusters: clusters}
  end

  def clusters(%Partition{clusters: clusters}) do
    clusters
  end

  def add_cluster(%Cluster{} = cluster) do
    %Partition{clusters: [cluster]}
  end

  def add_cluster(%Partition{clusters: clusters}, %Cluster{} = cluster) do
    %Partition{clusters: clusters ++ [cluster]}
  end

  def remove_cluster(%Partition{clusters: clusters}, %Cluster{} = cluster) do
    %Partition{clusters: clusters -- [cluster]}
  end

  def replace_cluster(%Partition{clusters: clusters} = partition, %Cluster{} = old_cluster, %Cluster{} = new_cluster) do
    unless clusters |> Enum.member?(old_cluster),
      do: raise ArgumentError, message: "old_cluster is not a member of the partition"

    partition
    |> remove_cluster(old_cluster)
    |> add_cluster(new_cluster)
  end

  def find_cluster(%Partition{clusters: clusters} = partition, %Transaction{} = transaction) do
    clusters
    |> Enum.find(fn(cluster) ->
      cluster |> Cluster.member?(transaction)
    end)
  end
end
