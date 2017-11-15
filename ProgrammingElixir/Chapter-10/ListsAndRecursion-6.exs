# ■練習問題: ListsAndRecursion-6
# (難問) flatten(list) 関数を書いてみよう。

defmodule MyList do
  def flatten(list), do: _flatten(list, [])

  defp _flatten(_list = [head | tail], result) when is_list(head) do
    # IO.puts "curren result is: #{inspect(result)}"
    # IO.puts "head is a list: #{inspect(head)}"
    # IO.puts "tail is #{inspect(tail)}"
    _flatten(head, result) ++ flatten(tail)
  end
  defp _flatten(_list = [head | tail], result) when is_number(head) do
    # IO.puts "curren result is: #{inspect(result)}"
    # IO.puts "head is a number: #{head}"
    # IO.puts "tail is: #{inspect(tail)}"
    _flatten(tail, result ++ [head])
  end
  defp _flatten([], result), do: result
end

# iex(2)> c "ListsAndRecursion-6.exs"
# warning: redefining module MyList (current version defined in memory)
#   ListsAndRecursion-6.exs:4
#
# [MyList]
# iex(3)> MyList.flatten [1, [2, 3, [4]], 5, [[[6]]]]
# [1, 2, 3, 4, 5, 6]
