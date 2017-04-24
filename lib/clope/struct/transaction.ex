defmodule Clope.Struct.Transaction do
  defstruct [:name, :items]

  alias Clope.Struct.Transaction

  @doc """
  Initialize a new Transaction struct.

      iex> Clope.Struct.Item.item("object")
      %Clope.Struct.Item{value: "object"}
  """
  def transaction(name, items)
      when is_binary(name)
      when is_list(items) do

    %Transaction{
      name: name,
      items: items
    }
  end
end
