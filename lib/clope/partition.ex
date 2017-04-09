defmodule Clope.Partition do
  defstruct clusters: []
  alias Clope.Partition
  alias Clope.Cluster

  def partition(clusters) when is_list(clusters) do
    %Partition{clusters: clusters}
  end

  def add_cluster(%Partition{clusters: clusters}, %Cluster{} = cluster) do
    %Partition{clusters: clusters ++ [cluster]}
  end

  def remove_cluster(%Partition{clusters: clusters}, %Cluster{} = cluster) do
    %Partition{clusters: clusters -- [cluster]}
  end
end
