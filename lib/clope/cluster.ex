defmodule Clope.Cluster do
  alias Clope.Transaction

  def cluster(transactions, repulsion) do
  end

  def number_of_transactions(cluster) do
    cluster |> Enum.count
  end

  def attributes(cluster) do
    cluster_stats = object_stats(cluster)
    width = cluster_stats |> Enum.count
    height = number_of_objects(cluster) / width

    {height, width}
  end

  def object_stats(cluster) do
    cluster |> Enum.reduce(%{}, &add_stats/2)
  end

  defp add_stats(transaction, result) do
    transaction_stats = transaction |> Transaction.object_stats

    result |> Map.merge(transaction_stats, fn(_key, value1, value2) ->
      value1 + value2
    end)
  end

  defp number_of_objects(cluster) do
    cluster
    |> Enum.reduce(0, fn({_name, objects}, count) ->
      count + Enum.count(objects)
    end)
  end
end
