# ■練習問題: ListsAndRecursion-7
# 「リストと再帰」(p.63)の最後の練習問題で、span 関数を書いた。…

defmodule MyList do
  def primes(2, 2), do: [2]

  def primes(2 = from, to) do
    undividable = for n <- span(from, to - 1), do: rem(to, n) != 0
    undividable = Enum.all?(undividable, &(&1 == true))
    if undividable do
      primes(from, to - 1) ++ [to]
    else
      primes(from, to - 1)
    end
  end

  def span(from, from), do: [from]
  def span(from, to) when from < to do
    [ from | span(from+1, to) ]
  end
  def span(from, to) when from > to do
    [ from | span(from-1, to) ]
  end
end

# iex(47)> c "ListsAndRecursion-7.exs"
# warning: redefining module MyList (current version defined in memory)
#   ListsAndRecursion-7.exs:4
#
# [MyList]
# iex(48)> MyList.primes(2,2)
# [2]
# iex(49)> MyList.primes(2,3)
# [2, 3]
# iex(50)> MyList.primes(2,10)
# [2, 3, 5, 7]
# iex(51)> MyList.primes(2,100)
# [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73,
#
#  79, 83, 89, 97]
