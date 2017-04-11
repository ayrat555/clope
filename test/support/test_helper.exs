defmodule Clope.TestHelper do
  alias Clope.Utils
  alias Clope.Cluster
  alias Clope.Partition
  alias Clope.Item
  alias Clope.Transaction

  def create(:transaction, items) do
    items = items
      |> Enum.uniq
      |> Enum.map(&Item.item/1)

    %Transaction{items: items}
  end

  def create(:cluster, transactions) do
    transactions = transactions |> Utils.prepare_transactions

    %Cluster{transactions: transactions}
  end

  def create(:partition, clusters) do
    clusters = clusters
      |> Enum.map(fn(transactions) ->
        create(:cluster, transactions)
      end)

    Partition.partition(clusters)
  end
end
