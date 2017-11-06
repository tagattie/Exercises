defmodule Factorial do
  def of(n), do: n * of(n - 1)
  def of(0), do: 1
end

# iex(6)> c "factorial1-bad.exs"
# warning: redefining module Factorial (current version defined in memory)
#   factorial1-bad.exs:1
#
# warning: this clause cannot match because a previous clause at line 2 always matches
#   factorial1-bad.exs:3
#
# [Factorial]
