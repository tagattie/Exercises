# ■練習問題: ModulesAndFunctions-4
# 1 から n までの整数の合計を計算するための関数 sum(n) を、再帰を使って実装し、実行してみよう。…

defmodule Sum do
  def sum(1), do: 1
  def sum(n), do: n + sum(n - 1)
end

# iex(1)> c "ModulesAndFunctions-4.exs"
# [Sum]
# iex(2)> Sum.sum(1)
# 1
# iex(3)> Sum.sum(2)
# 3
# iex(4)> Sum.sum(10)
# 55
