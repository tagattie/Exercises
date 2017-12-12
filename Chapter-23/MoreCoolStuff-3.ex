# ■練習問題: MoreCoolStuff-3
# (難問)ときどき、CSV ファイルの最初の行はカラム名であることがある。これを
# サポートするように更新し、各 CSV 行がカラム名をキーにしたキーワードリストに
# なるようにしよう。
#   csv = ~v"""
#   Item,Qty,Price
#   Teddy bear,4,34.95
#   Milk,1,2.99
#   Battery,6,8.00
#   """
# このプログラムは、次のリストを生成しなければならない。
#   [
#     [Item: "Teddy bear", Qty: 4, Price: 34.95],
#     [Item: "Milk", Qty: 1, Price: 2.99],
#     [Item: "Battery", Qty: 6, Price: 8.00]
#   ]

defmodule CSVSigil do
  def sigil_v(lines, _opts) do
    list_of_lines = lines |> String.trim_trailing |> String.split("\n")
    parse_list_of_lines(list_of_lines, [], [])
  end

  defp parse_list_of_lines(lines = [head | tail], [], []) do
    heading = head |> String.split(",")
    parse_list_of_lines(tail, heading, [])
  end
  defp parse_list_of_lines(lines = [head | tail], heading, formatted_lines) do
    {_, formatted_line} = head
    |> String.split(",")
    |> Enum.zip(heading)
    |> Keyword.new(fn({v, k}) ->
      {String.to_atom(k),
        case Float.parse(v) do
          {num, _rem} -> num
          :error -> v
        end
      } end)
    |> Keyword.get_and_update(:Qty, fn(v) ->
      {v,
        case Float.to_string(v) |> Integer.parse do
          {num, _rem} -> num
          :error -> v
        end }
      end)
    parse_list_of_lines(tail, heading, formatted_lines ++ [formatted_line])
  end
  defp parse_list_of_lines([], _, formatted_lines), do: formatted_lines
end

defmodule Test do
  import CSVSigil

  def csv do
    ~v"""
    Item,Qty,Price
    Teddy bear,4,34.95
    Milk,1,2.99
    Battery,6,8.00
    """
  end
end

IO.inspect Test.csv
