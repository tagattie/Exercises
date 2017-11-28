defmodule MyList do
  def len([]), do: 0
  def len([head | tail]), do: 1 + len(tail)
end

# > iex mylist.exs
# warning: variable "head" is unused
# Interactive Elixir (1.5.2) - press Ctrl+C to exit (type h() ENTER for help)
#  mylist.exs:3
#
# iex(1)> MyList.len([])
# 0
# iex(2)> MyList.len([11,12,13,14,15])
# 5
