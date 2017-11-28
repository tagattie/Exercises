# ■練習問題: ListsAndRecursion-3
# Elixir のシングルクォートで囲まれた文字列は、実際は個々の文字コードのリストだ。…

defmodule Ceaser do
  def ceaser([], _), do: []
  def ceaser(_list = [head | tail], n) when head+n > 122 do  # z: 122
    [head+n-26 | ceaser(tail, n)]                            # a: 26
  end
  def ceaser(_list = [head | tail], n) do
    [head+n | ceaser(tail, n)]
  end
end

# iex(50)> c "ListsAndRecursion-3.exs"
# warning: redefining module Ceaser (current version defined in memory)
#   ListsAndRecursion-3.exs:4

# [Ceaser]
# iex(51)> Ceaser.ceaser('ryvkve', 13)
# 'elixir'
