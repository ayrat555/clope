defmodule Clope.Algorithm do
  def clusters(transactions, repulsion) do
    clusters = []
    
    transactions
    |> Enum.each(fn(transaction) ->
      cluster = [transaction]
      clusters = [cluster]
    end)
  end
end
