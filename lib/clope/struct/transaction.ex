defmodule Clope.Struct.Transaction do
  defstruct [:name, :items]

  alias Clope.Struct.Transaction
  @moduledoc false

  def transaction(name, items)
      when is_binary(name)
      when is_list(items) do

    %Transaction{
      name: name,
      items: items
    }
  end
end
