defmodule Clope.UtilsTest do
  use ExUnit.Case
  alias Clope.Utils
  alias Clope.Struct.Transaction
  alias Clope.Struct.Item

  @input_transactions [
    {"transaction1", ["item1", "item2"]},
    {"transaction2", ["item5", "item1"]}
  ]

  test "converts input data to internal represantation" do
    result = @input_transactions |> Utils.internalize_transactions

    [%Transaction{
        name: "transaction1",
        items: [
          %Item{value: "item1"},
          %Item{value: "item2"}
        ]},
     %Transaction{
       name: "transaction2",
       items: [
         %Item{value: "item5"},
         %Item{value: "item1"}
       ]}
    ] = result
  end
end
