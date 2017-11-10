defmodule MyList do
  def len([]), do: 0
  def len([_head | tail]), do: 1 + len(tail)

  def square([]), do: []
  def square([head | tail]), do: [ head*head | square(tail) ]

  def add_1([]), do: []
  def add_1([head | tail]), do: [ head+1 | add_1(tail) ]

  def map([], _func), do: []
  def map([head | tail], func), do: [ func.(head) | map(tail, func) ]
end

# iex(3)> c "mylist1.exs"
# warning: redefining module MyList (current version defined in memory)
#   mylist1.exs:1
#
# [MyList]
# iex(4)> MyList.len([1,2,3,4,5])
# 5
# iex(5)> MyList,len(["cat", "dog"])
# ** (SyntaxError) iex:5: syntax error before: ','
#
# iex(5)> MyList.len(["cat", "dog"])
# 2

# iex(6)> c "mylist1.exs"
# warning: redefining module MyList (current version defined in memory)
#   mylist1.exs:1
#
# [MyList]
# iex(7)> MyList.square []
# []
# iex(8)> MyList.square [4,5,6]
# [16, 25, 36]

# iex(9)> c "mylist1.exs"
# warning: redefining module MyList (current version defined in memory)
#   mylist1.exs:1
#
# [MyList]
# iex(10)> MyList.add_1 [1000]
# [1001]
# iex(11)> MyList.add_1 [4,6,8]
# [5, 7, 9]

# iex(1)> c "mylist1.exs"
# [MyList]
# iex(2)> MyList.map [1,2,3,4], fn (n) -> n*n end
# [1, 4, 9, 16]
# iex(3)> MyList.map [1,2,3,4], fn (n) -> n+1 end
# [2, 3, 4, 5]
# iex(4)> MyList.map [1,2,3,4], fn (n) -> n > 2 end
# [false, false, true, true]
# iex(5)> MyList.map [1,2,3,4], &(&1+1)
# [2, 3, 4, 5]
# iex(6)> MyList.map [1,2,3,4], &(&1 > 2)
# [false, false, true, true]
