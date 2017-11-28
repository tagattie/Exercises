# ■練習問題: ModulesAndFunctions-5
# 二つの負ではない整数の最大公約数を求める関数 gcd(x, y) を書いてみよう。…

defmodule GCD do
  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))
end

# iex(5)> c "ModulesAndFunctions-5.exs"
# [GCD]
# iex(6)> gcd(10, 0)
# ** (CompileError) iex:6: undefined function gcd/2
#
# iex(6)> GCD.gcd(10, 0)
# 10
# iex(7)> GCD.gcd(10, 333)
# 1
# iex(8)> GCD.gcd(33, 333)
# 3
# iex(9)> GCD.gcd(27, 333)
# 9
