defmodule Clope.Object do
  @enforce_keys [:value]
  defstruct [:value]

  def object(value) when is_binary(value), do: %Clope.Object{value: value}
end
