defmodule Clope.TestHelper do
  alias Clope.Transaction
  alias Clope.Item

  def transaction_stats(transactions) when is_list(transactions) do
    {res_transaction_count, res_item_count, res_occ} =
      transactions
      |> Enum.reduce({0, 0, %{}}, fn(
          %Transaction{items: items},
          {transaction_count, item_count, occ}) ->
        {trans_item_count, trans_occ} = items |> item_stats
        occ =
          occ
          |> Map.merge(trans_occ, fn(_k, v1, v2) ->
            v1 + v2
          end)

        {transaction_count + 1, item_count + trans_item_count, occ}
      end)
    res_width = res_occ |> Enum.count

    {res_transaction_count, res_item_count, res_width, res_occ}
  end

  def item_stats(items) when is_list(items) do
    items
    |> Enum.reduce({0, %{}}, fn(
        %Item{value: value},
        {item_count, occ}) ->
      occ = occ |> Map.update(value, 1, &(&1 + 1))

      {item_count + 1, occ}
    end)
  end
end
