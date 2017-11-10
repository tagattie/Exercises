defmodule MyList do
  def sum([], total), do: total
  def sum([head | tail], total), do: sum(tail, head+total)
end

# iex(7)> c "sum.exs"
# warning: redefining module MyList (current version defined in memory)
#   sum.exs:1
#
# [MyList]
# iex(8)> MyList.sum([1,2,3,4,5], 0)
# 15
# iex(9)> MyList.sum([11,12,13,14,15], 0)
# 65
