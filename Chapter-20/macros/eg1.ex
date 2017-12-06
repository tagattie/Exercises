defmodule My do
  defmacro macro(code) do
    IO.inspect code
    quote do: IO.puts "Different code"
  end
end

defmodule Test do
  require My
  My.macro(IO.puts("hello"))
end

# iex(1)> c "eg.ex"
# {{:., [line: 10], [{:__aliases__, [counter: 0, line: 10], [:IO]}, :puts]},
#  [line: 10], ["hello"]}
# hello
# [Test, My]
# iex(2)> c "eg1.ex"
# warning: redefining module My (current version defined in memory)
#   eg1.ex:1

# warning: redefining module Test (current version defined in memory)
#   eg1.ex:8

# {{:., [line: 10], [{:__aliases__, [counter: 0, line: 10], [:IO]}, :puts]},
#  [line: 10], ["hello"]}
# Different code
# [Test, My]
