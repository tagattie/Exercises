defmodule MyList do
  def reduce([], value, _) do
    value
  end
  def reduce([head | tail], value, func) do
    reduce(tail, func.(head, value), func)
  end
end

# iex(20)> c "lists/reduce.exs"
# [MyList]
# iex(21)> MyList.reduce([1,2,3,4,5], 0, &(&1 + &2))
# 15
# iex(22)> MyList.reduce([1,2,3,4,5], 1, &(&1 * &2))
# 120
