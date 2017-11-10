# ■練習問題: ListsAndRecursion-0
# 先ほど定義した sum 関数では、その時々の合計を第二引数として引き回すようにした。…

defmodule MySum do
  def sum([head | []]), do: head
  def sum([head | tail]) when is_number(tail), do: head+tail
  def sum([head | tail]) when is_list(tail) do
    [nexthead | nexttail] = tail
    sum([head+nexthead | nexttail])
  end
end

# iex(17)> c "ListsAndRecursion-0.exs"
# warning: redefining module MySum (current version defined in memory)
#   ListsAndRecursion-0.exs:4

# [MySum]
# iex(18)> MySum.sum([1,2,3,4,5])
# 15
# iex(19)> MySum.sum([11,12,13,14,15])
# 65
