defmodule Example do
  def func1 do
    List.flatten [1,[2,3],4]
  end
  def func2 do
    import List, only: [flatten: 1]
    flatten [5,[6,7],8]
  end
end

# iex(1)> Example.func1
# [1, 2, 3, 4]
# iex(2)> Example.func2
# [5, 6, 7, 8]
