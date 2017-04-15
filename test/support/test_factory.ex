defmodule Clope.TestFactory do
  use ExMachina
  import Clope.TestHelper

  alias Clope.Utils
  alias Clope.Cluster
  alias Clope.Partition
  alias Clope.Item
  alias Clope.Transaction

  def transaction_factory do
    %Transaction{
      name: sequence("transaction"),
      items: build_list(3, :item)
    }
  end

  def item_factory do
    %Item{value: sequence("value")}
  end

  def cluster_factory do
    transactions = build_random_list(10, :transaction)
    {transaction_count, item_count, width, occ} = transactions |> transaction_stats

    %Cluster{
      transactions: transactions,
      transaction_count: transaction_count,
      width: width,
      item_count: item_count,
      occ: occ
    }
  end

  def build_random_list(max_transaction_count, :transaction, unique_item_count \\ 10) do
    item_pool = :random.uniform(unique_item_count) |> build_list(:item)
    transaction_count = max_transaction_count |> :random.uniform

    1..transaction_count
    |> Enum.map(fn(_) ->
      item_count = unique_item_count |> :random.uniform
      items = item_pool |> Enum.take_random(item_count)

      build(:transaction, %{items: items})
    end)
  end

  def build_from_string(:cluster, transactions) do
    transactions = transactions |> Utils.prepare_transactions
    {transaction_count, item_count, width, occ} = transactions |> transaction_stats

    %Cluster{
      transactions: transactions,
      transaction_count: transaction_count,
      width: width,
      item_count: item_count,
      occ: occ
    }
  end

  def build_from_string(:partition, clusters) do
    clusters = clusters
      |> Enum.map(fn(transactions) ->
        build_from_string(:cluster, transactions)
      end)

    Partition.partition(clusters)
  end
end
