defmodule Clope.Struct.Item do
  @enforce_keys [:value]
  defstruct [:value]
  alias Clope.Struct.Item
  @moduledoc false

  def item(value), do: %Item{value: value}
end
