defmodule Clope.Transaction do
  def object_stats({_name, objects}) do
    objects |> Enum.reduce(%{}, &add_stats/2)
  end

  defp add_stats(object, result) do
    Map.put(result, object, 1)
  end
end
