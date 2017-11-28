# ■練習問題: ControlFlow-1
# FizzBuzz の例を case を使って書き換えてみよう。

defmodule FizzBuzz do
  def upto(n), do: _fizzbuzz(1, n)

  def _fizzbuzz(n, l) when n > 0 and n <= l do
    head = case {rem(n, 3), rem(n, 5)} do
      {0, 0} -> "FizzBuzz"
      {0, _} -> "Fizz"
      {_, 0} -> "Buzz"
      {_, _} -> n
    end
    [ head | _fizzbuzz(n+1, l) ]
  end
  def _fizzbuzz(n, l) when n > l, do: []
end
