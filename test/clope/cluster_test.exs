defmodule Clope.ClusterTest do
  use ExUnit.Case
  alias Clope.Cluster
  alias Clope.Transaction
  alias Clope.Item

  @cluster %Cluster{
    transactions: [
      %Transaction{
        items: [
          %Item{value: "item1"},
          %Item{value: "item2"},
          %Item{value: "item5"}
        ]
      },
      %Transaction{
        items: [
          %Item{value: "item1"},
          %Item{value: "item5"}
        ]
      }
    ]
  }

  test "returns number of transactions" do
    result = @cluster |> Cluster.number_of_transactions

    assert result == 2
  end

  test "calculates cluster stats" do
    result = @cluster |> Cluster.item_stats

    %{"item1" => 2} = result
    %{"item2" => 1} = result
    %{"item5" => 2} = result
  end

  test "calculates cluster attributes" do
    result = @cluster |> Cluster.attributes

    { 5/3, 3 } = result
  end
end
