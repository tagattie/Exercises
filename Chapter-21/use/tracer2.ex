defmodule Tracer do
  defmacro def(definition, do: content) do
    IO.inspect definition
    quote do
      Kernel.def(unquote(definition)) do
        unquote(content)
      end
    end
  end
end

defmodule Test do
  import Kernel, except: [def: 2]
  import Tracer, only:   [def: 2]

  def puts_sum_three(a, b, c), do: IO.inspect(a + b + c)
  def add_list(list),          do: Enum.reduce(list, 0, &(&1+&2))
end

Test.puts_sum_three(1,2,3)
Test.add_list([5,6,7,8])

# iex(1)> c "tracer2.ex"
# {:puts_sum_three, [line: 16],
#  [{:a, [line: 16], nil}, {:b, [line: 16], nil}, {:c, [line: 16], nil}]}
# {:add_list, [line: 17], [{:list, [line: 17], nil}]}
# 6
# [Test, Tracer]
