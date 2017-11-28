defmodule Guard do
  def what_is(x) when is_number(x) do
    IO.puts "#{x} is a number"
  end
  def what_is(x) when is_list(x) do
    IO.puts "#{inspect(x)} is a list"
  end
  def what_is(x) when is_atom(x) do
    IO.puts "#{x} is an atom"
  end
  def what_is(x) when is_tuple(x) or is_map(x) do
    IO.puts "#{inspect(x)} is a tuple or a map"
  end
end

# iex(2)> Guard.what_is(99)
# 99 is a number
# :ok
# iex(3)> Guard.what_is(:cat)
# cat is an atom
# :ok
# iex(4)> Guard.what_is([1,2,3])
# [1, 2, 3] is a list
# :ok

# iex(4)> Guard.what_is(%{:a=>1, :b=>2})
# %{a: 1, b: 2} is a tuple or a map
# :ok
# iex(5)> Guard.what_is({1,2,3})
# {1, 2, 3} is a tuple or a map
# :ok
# iex(6)> Guard.what_is({:a,:b,:c})
# {:a, :b, :c} is a tuple or a map
# :ok
