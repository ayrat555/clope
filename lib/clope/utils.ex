defmodule Clope.Utils do
  alias Clope.Transaction
  alias Clope.Object

  def prepare_transactions(transactions) when is_list(transactions) do
    transactions |> Enum.map(&prepare_transaction/1)
  end

  defp prepare_transaction({name, objects})
      when is_binary(name)
      when is_list(objects) do
    objects = objects |> prepare_objects

    Transaction.transaction(name, objects)
  end

  defp prepare_objects(objects) do
   objects
   |> Enum.uniq
   |> Enum.map(&Object.object/1)
  end
end
