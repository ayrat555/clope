defmodule Clope.Item do
  @enforce_keys [:value]
  defstruct [:value]

  def item(value) when is_binary(value), do: %Clope.Item{value: value}
end
