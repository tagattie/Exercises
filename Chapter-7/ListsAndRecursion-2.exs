# ■練習問題: ListsAndRecursion-2
# リストの要素の最大値を返す max(list) を書いてみよう(思ったより、ややトリッキーになる)。

defmodule Max do
  def max(list), do: _max(list, 0)

  defp _max([], value), do: value
  defp _max([head | tail], value) when head > value do
    _max(tail, head)
  end
  defp _max([head | tail], value) when head <= value and value == 0 do
    _max(tail, head)
  end
  defp _max([head | tail], value) when head <= value do
    _max(tail, value)
  end
end

# iex(1)> c "ListsAndRecursion-2.exs"
# [Max]
# iex(2)> Max.max([1,2,3,4,5])
# 5
# iex(3)> Max.max([1,5,2,4,3])
# 5
# iex(4)> Max.max([-1,-2,-3,-4,-5])
# -1
# iex(5)> Max.max([-1,-5,-3,-4,-2])
# -1
# iex(6)> Max.max([-1,5,-3,-4,2])
# 5
