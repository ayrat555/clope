defmodule Clope.UtilsTest do
  use ExUnit.Case
  alias Clope.Utils

  @input_transactions [
    {"transaction1", ["item1", "item2"]},
    {"transaction2", ["item5", "item1"]}
  ]

  test "converts input data to internal represantation" do
    result = @input_transactions |> Utils.prepare_transactions

    [%Clope.Transaction{
        name: "transaction1",
        items: [
          %Clope.Item{value: "item1"},
          %Clope.Item{value: "item2"}
        ]},
     %Clope.Transaction{
       name: "transaction2",
       items: [
         %Clope.Item{value: "item5"},
         %Clope.Item{value: "item1"}
       ]}
    ] = result
  end
end
