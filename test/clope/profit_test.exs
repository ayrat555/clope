defmodule Clope.ProfitTest do
  use ExUnit.Case
  alias Clope.Profit
  alias Clope.Partition
  alias Clope.Cluster
  alias Clope.Transaction
  alias Clope.Item

  @partition %Partition{
    clusters: [
      %Cluster{
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
      },
      %Cluster{
        transactions: [
          %Transaction{
            items: [
              %Item{value: "item2"}
            ]
          }
        ]
      }
    ]
  }
  @repulsion 2


  test "calculates profit function value" do
    profit = Profit.value(@partition, @repulsion)
    expected_profit = (3 * 5 / 3 / 9 * 2 + 1) / 3

    assert profit == expected_profit
  end
end
