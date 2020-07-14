defmodule Clope.Struct.ClusterTest do
  use ExUnit.Case
  import Clope.TestFactory
  import Clope.TestHelper
  alias Clope.Struct.Cluster

  test "recalculates cluster attributes when a new transaction is added" do
    %Cluster{transactions: transactions} = cluster = build(:cluster)
    new_transaction = build(:transaction)

    %Cluster{
      transactions: new_transactions,
      transaction_count: new_transaction_count,
      width: new_width,
      item_count: new_item_count,
      occ: new_occ
    } = cluster |> Cluster.add_transaction(new_transaction)

    assert new_transactions == transactions ++ [new_transaction]

    {
      transaction_count,
      item_count,
      width,
      occ
    } = new_transactions |> transaction_stats

    assert transaction_count == new_transaction_count
    assert width == new_width
    assert item_count == new_item_count
    assert occ == new_occ
  end

  test "recalculates cluster attributes when transaction is removed" do
    %Cluster{transactions: transactions} = cluster = build(:cluster)
    transaction = transactions |> Enum.at(0)

    %Cluster{
      transactions: new_transactions,
      transaction_count: new_transaction_count,
      width: new_width,
      item_count: new_item_count,
      occ: new_occ
    } = cluster |> Cluster.remove_transaction(transaction)

    assert new_transactions == transactions -- [transaction]

    {
      transaction_count,
      item_count,
      width,
      occ
    } = new_transactions |> transaction_stats

    assert transaction_count == new_transaction_count
    assert width == new_width
    assert item_count == new_item_count
    assert occ == new_occ
  end
end
