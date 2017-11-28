defmodule MyList do
  def sum(list), do: _sum(list, 0)

  # プライベート関数
  defp _sum([], total), do: total
  defp _sum([head | tail], total), do: _sum(tail, head+total)
end

# iex(10)> c "sum2.exs"
# warning: redefining module MyList (current version defined in memory)
#   sum2.exs:1
#
# [MyList]
# iex(11)> MyList.sum([1,2,3,4,5])
# 15
# iex(12)> MyList.sum([11,12,13,14,15])
# 65
