defmodule Clope.Transaction do
  defstruct [:objects, :name]

  alias Clope.Transaction
  alias Clope.Object

  def number_of_objects(%Transaction{objects: objects}) do
    objects |> Enum.count
  end

  def object_stats(%Transaction{objects: objects}) do
    objects |> Enum.reduce(%{}, &add_stats/2)
  end

  defp add_stats(%Object{value: value}, result) do
    Map.put(result, value, 1)
  end
end
