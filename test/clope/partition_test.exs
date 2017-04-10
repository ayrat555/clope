defmodule Clope.PartitionTest do
  use ExUnit.Case
  alias Clope.TestHelper
  alias Clope.Partition

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
    partition = TestHelper.create(:partition, partition)
    new_cluster = TestHelper.create(:cluster, new_cluster)

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
    cluster_to_remove = TestHelper.create(:cluster, Enum.at(partition, 1))
    partition = TestHelper.create(:partition, partition)

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
    cluster_to_replace = TestHelper.create(:cluster, Enum.at(partition, 1))
    partition = TestHelper.create(:partition, partition)
    new_cluster = TestHelper.create(:cluster, new_cluster)

    new_partition = partition |> Partition.replace_cluster(cluster_to_replace, new_cluster)

    %Partition{clusters: new_clusters} = new_partition
    refute new_clusters |> Enum.member?(cluster_to_replace)
    assert new_clusters |> Enum.member?(new_cluster)
  end
end
