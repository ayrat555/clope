defmodule Clope.Transaction do
  defstruct [:name, :items]

  alias Clope.Transaction
  alias Clope.Item

  def transaction(name, items)
      when is_binary(name)
      when is_list(items) do

    %Transaction{
      name: name,
      items: items
    }
  end
end
