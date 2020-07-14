defmodule Clope.Struct.TransactionTest do
  use ExUnit.Case
  import Clope.TestFactory
  alias Clope.Struct.Transaction

  test "creates valid transaction" do
    items = build_list(3, :item)
    name = "transaction"

    %Transaction{
      name: ^name,
      items: ^items
    } = Transaction.transaction(name, items)
  end
end
