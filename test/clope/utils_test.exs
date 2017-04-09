defmodule Clope.UtilsTest do
  use ExUnit.Case
  alias Clope.Utils

  @input_transactions [
    {"transaction1", ["object1", "object2"]},
    {"transaction2", ["object5", "object1"]}
  ]

  test "converts input data to internal represantation" do
    result = @input_transactions |> Utils.prepare_transactions

    [%Clope.Transaction{
        name: "transaction1",
        objects: [
          %Clope.Object{value: "object1"},
          %Clope.Object{value: "object2"}
        ]},
     %Clope.Transaction{
       name: "transaction2",
       objects: [
         %Clope.Object{value: "object5"},
         %Clope.Object{value: "object1"}
       ]}
    ] = result
  end
end
