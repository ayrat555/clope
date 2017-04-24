defmodule Clope.Struct.Item do
  @enforce_keys [:value]
  defstruct [:value]
  alias Clope.Struct.Item

  @doc """
  Initialize a new Item struct.

      iex> Clope.Struct.Item.item("object")
      %Clope.Struct.Item{value: "object"}
  """
  def item(value) when is_binary(value), do: %Item{value: value}
end
