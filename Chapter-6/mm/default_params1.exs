defmodule DefaultParams1 do

  def func(p1, p2 \\ 123) do
    IO.inspect [p1, p2]
  end

  def func(p1, 99) do
    IO.puts "you said 99"
  end

end

# iex(20)> c "default_params1.exs"
# warning: definitions with multiple clauses and default values require a header. Instead of:
#
#     def foo(:first_clause, b \\ :default) do ... end
#     def foo(:second_clause, b) do ... end
#
# one should write:
#
#     def foo(a, b \\ :default)
#     def foo(:first_clause, b) do ... end
#     def foo(:second_clause, b) do ... end
#
# def func/2 has multiple clauses and defines defaults in one or more clauses
#   default_params1.exs:7
#
# warning: variable "p1" is unused
#   default_params1.exs:7
#
# warning: this clause cannot match because a previous clause at line 3 always matches
#   default_params1.exs:7
#
# [DefaultParams1]
#
# Error でなく warning になるみたい @ Elixir 1.5.2
