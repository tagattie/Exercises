defmodule Example do
  @attr "One"
  def first, do: @attr
  @attr "Two"
  def second, do: @attr
end

IO.puts "#{Example.first} #{Example.second}"

# iex(4)> c "attributes1.exs"
# warning: redefining module Example (current version defined in memory)
#   attributes1.exs:1
#
# One Two
# [Example]
