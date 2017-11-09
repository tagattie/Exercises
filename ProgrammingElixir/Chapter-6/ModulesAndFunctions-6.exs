# ■練習問題: ModulesAndFunctions-6
# 1 から 1000 までの間の数を一つ、思い浮かべてほしい。…

defmodule Chop do

  def guess(actual, range) do
    low..high = range
    mid = fn (low, high) -> div(low+high, 2) end
    guessed = mid.(low, high)
    IO.puts "Is it #{guessed}"
    guess_next(actual, guessed, low, high)
  end

  def guess_next(actual, guessed, _, _) when actual == guessed, do: actual
  def guess_next(actual, guessed, low, _) when actual < guessed do
    guess(actual, low..guessed-1)
  end
  def guess_next(actual, guessed, _, high) when actual > guessed do
    guess(actual, guessed+1..high)
  end

end

# iex(31)> c "ModulesAndFunctions-6.exs"
# warning: redefining module Chop (current version defined in memory)
#   ModulesAndFunctions-6.exs:4
#
# [Chop]
# iex(32)> Chop.guess(273, 1..1000)
# Is it 500
# Is it 250
# Is it 375
# Is it 312
# Is it 281
# Is it 265
# Is it 273
# 273
