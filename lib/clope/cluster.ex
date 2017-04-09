defmodule Clope.Cluster do
  defstruct [:transactions]

  alias Clope.Transaction
  alias Clope.Cluster

  def cluster(transactions, repulsion) do
  end

  def add_transaction(%Cluster{transactions: transactions}, %Transaction{} = transaction) do
    new_transactions = transactions ++ transaction

    %Cluster{transactions: new_transactions}
  end

  def remove_transaction(%Cluster{transactions: transactions}, %Transaction{} = transaction) do
    new_transactions = transactions -- transaction

    %Cluster{transactions: new_transactions}
  end

  def number_of_transactions(%Cluster{transactions: transactions}) do
    transactions |> Enum.count
  end

  def attributes(%Cluster{} = cluster) do
    cluster_stats = object_stats(cluster)
    width = cluster_stats |> Enum.count
    height = number_of_objects(cluster) / width

    {height, width}
  end

  def object_stats(%Cluster{transactions: transactions}) do
    transactions |> Enum.reduce(%{}, &add_stats/2)
  end

  defp add_stats(%Transaction{} = transaction, result) do
    transaction_stats = transaction |> Transaction.object_stats

    result |> Map.merge(transaction_stats, fn(_key, value1, value2) ->
      value1 + value2
    end)
  end

  defp number_of_objects(%Cluster{transactions: transactions}) do
    transactions
    |> Enum.reduce(0, fn(transaction, count) ->
      count + Transaction.number_of_objects(transaction)
    end)
  end
end
