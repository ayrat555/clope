defmodule Clope.Utils do
  alias Clope.Struct.Partition
  alias Clope.Struct.Cluster
  alias Clope.Struct.Transaction
  alias Clope.Struct.Item
  @moduledoc false

  def internalize_transactions(transactions) when is_list(transactions) do
    transactions |> Enum.map(&internalize_transaction/1)
  end

  def internalize_transaction({name, items})
      when is_binary(name)
      when is_list(items) do
    items = items |> internalize_items

    Transaction.transaction(name, items)
  end

  def internalize_items(items) do
    items
    |> Enum.uniq()
    |> Enum.map(&Item.item/1)
  end

  def externalize_partition(%Partition{clusters: clusters}) do
    clusters |> Enum.map(&externalize_cluster/1)
  end

  def externalize_cluster(%Cluster{transactions: transactions}) do
    transactions |> Enum.map(&externalize_transaction/1)
  end

  def externalize_transaction(%Transaction{name: name, items: items}) do
    items =
      items
      |> Enum.map(fn %Item{value: value} ->
        value
      end)

    {name, items}
  end
end
