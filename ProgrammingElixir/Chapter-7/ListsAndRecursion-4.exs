# ■練習問題: ListsAndRecursion-4
# from から to までの数のリストを返す関数 MyList.span(from, to) を書いてみよう。

defmodule MyList do
  def span(from, from), do: [from]
  def span(from, to) when from < to do
    [ from | span(from+1, to) ]
  end
  def span(from, to) when from > to do
    [ from | span(from-1, to) ]
  end
end

# iex(1)> c "ListsAndRecursion-4.exs"
# [MyList]
# iex(2)> MyList.span(1,1)
# [1]
# iex(3)> MyList.span(1,2)
# [1, 2]
# iex(4)> MyList.span(1,10)
# [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
# iex(5)> MyList.span(-5,5)
# [-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5]
# iex(6)> MyList.span(5,-5)
# [5, 4, 3, 2, 1, 0, -1, -2, -3, -4, -5]
