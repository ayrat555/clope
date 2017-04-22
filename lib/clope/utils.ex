defmodule Clope.Utils do
  alias Clope.Struct.Transaction
  alias Clope.Struct.Item

  def prepare_transactions(transactions) when is_list(transactions) do
    transactions |> Enum.map(&prepare_transaction/1)
  end

  def prepare_transaction({name, items})
      when is_binary(name)
      when is_list(items) do
    items = items |> prepare_items

    Transaction.transaction(name, items)
  end

  def prepare_items(items) do
   items
   |> Enum.uniq
   |> Enum.map(&Item.item/1)
  end
end
