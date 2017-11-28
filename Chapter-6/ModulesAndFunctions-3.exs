# ■練習問題: ModulesAndFunctions-3
# 引数を 4倍にする quadruple 関数を追加してみよう(多分、double 関数を使うんじゃないかな)。

defmodule Times do
  def double(n), do: n * 2
  def triple(n), do: n * 3
  def quadruple(n), do: double(n) * 2
end

# iex(7)> c "ModulesAndFunctions-3.exs"
# warning: redefining module Times (current version defined in memory)
#   ModulesAndFunctions-3.exs:4
#
# [Times]
# iex(8)> Times.quadruple
# ** (UndefinedFunctionError) function Times.quadruple/0 is undefined or private. Did you mean one of:
#
#       * quadruple/1
#
#     Times.quadruple()
# iex(8)> Times.quadruple(10)
# 40
# iex(9)> Times.quadruple(0.05)
# 0.2
