defmodule Clope.Struct.Partition do
  defstruct clusters: []
  alias Clope.Struct.Partition
  alias Clope.Struct.Cluster
  alias Clope.Struct.Transaction
  @moduledoc false

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

  def replace_cluster(
        %Partition{} = partition,
        %Cluster{} = old_cluster,
        %Cluster{} = new_cluster
      ) do
    partition
    |> remove_cluster(old_cluster)
    |> add_cluster(new_cluster)
  end

  def find_cluster(%Partition{clusters: clusters}, %Transaction{} = transaction) do
    clusters
    |> Enum.find(fn cluster ->
      cluster |> Cluster.member?(transaction)
    end)
  end
end
