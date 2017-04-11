defmodule Clope.Transaction do
  defstruct [:items, :name]

  alias Clope.Transaction
  alias Clope.Item

  def transaction(name, items)
      when is_binary(name)
      when is_list(items) do
    %Transaction{name: name, items: items}
  end

  def number_of_items(%Transaction{items: items}) do
    items |> Enum.count
  end

  def item_stats(%Transaction{items: items}) do
    items |> Enum.reduce(%{}, &add_stats/2)
  end

  defp add_stats(%Item{value: value}, result) do
    Map.put(result, value, 1)
  end
end
