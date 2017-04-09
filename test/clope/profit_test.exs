defmodule Clope.ProfitTest do
  use ExUnit.Case
  alias Clope.Profit
  alias Clope.Partition
  alias Clope.Cluster
  alias Clope.Transaction
  alias Clope.Object

  @partition %Partition{
    clusters: [
      %Cluster{
        transactions: [
          %Transaction{
            objects: [
              %Object{value: "object1"},
              %Object{value: "object2"},
              %Object{value: "object5"}
            ]
          },
          %Transaction{
            objects: [
              %Object{value: "object1"},
              %Object{value: "object5"}
            ]
          }
        ]
      },
      %Cluster{
        transactions: [
          %Transaction{
            objects: [
              %Object{value: "object2"}
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
