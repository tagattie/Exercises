defmodule Swapper do
  def swap([]), do: []
  def swap([ a, b | tail ]), do: [ b, a | swap(tail) ]
  def swap([_]), do: raise "Can't swap a list with an odd number of elements"
end

# iex(2)> c "lists/swap.exs"
# [Swapper]
# iex(3)> Swapper.swap([1,2,3,4,5,6])
# [2, 1, 4, 3, 6, 5]
# iex(4)> Swapper.swap([1,2,3,4,5,6,7])
# ** (RuntimeError) Can't swap a list with an odd number of elements
#     lists/swap.exs:4: Swapper.swap/1
#     lists/swap.exs:3: Swapper.swap/1
