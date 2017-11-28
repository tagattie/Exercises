# ■練習問題: ListsAndRecursion-1
# リストと関数を引数に取る mapsum 関数を書いてみよう。…

defmodule MyList do
  def mapsum([], _), do: 0
  def mapsum([head | tail], func) do
    func.(head) + mapsum(tail, func)
  end
end

# iex(23)> c "ListsAndRecursion-1.exs"
# warning: redefining module MyList (current version defined in memory)
#   ListsAndRecursion-1.exs:4

# [MyList]
# iex(24)> MyList.mapsum([1,2,3,4,5], &(&1+1))
# 20
# iex(25)> MyList.mapsum([1,2,3,4,5], &(&1+&1))
# 30
# iex(26)> MyList.mapsum([1,2,3,4,5], &(&1*&1))
# 55
# iex(28)> MyList.mapsum [1,2,3], &(&1*&1)
# 14
