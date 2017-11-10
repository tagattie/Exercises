defmodule MyList do
  def len([]), do: 0
  def len([_head | tail]), do: 1 + len(tail)

  def square([]), do: []
  def square([head | tail]), do: [ head*head | square(tail) ]

  def add_1([]), do: []
  def add_1([head | tail]), do: [ head+1 | add_1(tail) ]
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
