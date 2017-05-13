defmodule Clope.Struct.PartitionTest do
  use ExUnit.Case
  import Clope.TestFactory
  alias Clope.Struct.Partition

  test "adds cluster to partition" do
    partition = [
      [
        {"transaction1", ["object1", "object2"]},
        {"transaction2", ["object5", "object6"]}
      ],
      [
        {"transaction3", ["object5", "object2"]},
        {"transaction4", ["object5", "object1"]}
      ]
    ]
    new_cluster = [
      {"transaction7", ["object1", "object2"]},
      {"transaction9", ["object5", "object6"]}
    ]
    partition = build_from_string(:partition, partition)
    new_cluster = build_from_string(:cluster, new_cluster)

    new_partition = partition |> Partition.add_cluster(new_cluster)

    %Partition{clusters: new_clusters} = new_partition
    assert new_clusters |> Enum.member?(new_cluster)
  end

  test "deletes cluster from partition" do
    partition = [
      [
        {"transaction1", ["object1", "object2"]},
        {"transaction2", ["object5", "object6"]}
      ],
      [
        {"transaction3", ["object5", "object2"]},
        {"transaction4", ["object5", "object1"]}
      ]
    ]
    cluster_to_remove = build_from_string(:cluster, Enum.at(partition, 1))
    partition = build_from_string(:partition, partition)

    new_partition = partition |> Partition.remove_cluster(cluster_to_remove)

    %Partition{clusters: new_clusters} = new_partition
    refute new_clusters |> Enum.member?(cluster_to_remove)
  end

  test "replaces cluster with a new one" do
    partition = [
      [
        {"transaction1", ["object1", "object2"]},
        {"transaction2", ["object5", "object6"]}
      ],
      [
        {"transaction3", ["object5", "object2"]},
        {"transaction4", ["object5", "object1"]}
      ]
    ]
    new_cluster = [
      {"transaction7", ["object1", "object2"]},
      {"transaction9", ["object5", "object6"]}
    ]
    partition = build_from_string(:partition, partition)
    %Partition{clusters: clusters} = partition
    cluster_to_replace = clusters |> Enum.at(1)
    new_cluster = build_from_string(:cluster, new_cluster)

    new_partition = partition |> Partition.replace_cluster(cluster_to_replace, new_cluster)

    %Partition{clusters: new_clusters} = new_partition
    refute new_clusters |> Enum.member?(cluster_to_replace)
    assert new_clusters |> Enum.member?(new_cluster)
  end
end
