defmodule Tracer do
  defmacro def(definition, do: _content) do
    IO.inspect definition
    quote do: {}
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

# iex(1)> c "tracer1.ex"
# {:puts_sum_three, [line: 12],
#  [{:a, [line: 12], nil}, {:b, [line: 12], nil}, {:c, [line: 12], nil}]}
# {:add_list, [line: 13], [{:list, [line: 13], nil}]}
#
# == Compilation error in file tracer1.ex ==
# ** (UndefinedFunctionError) function Test.puts_sum_three/3 is undefined or private
#     Test.puts_sum_three(1, 2, 3)
#     tracer1.ex:16: (file)
#     (elixir) lib/kernel/parallel_compiler.ex:121: anonymous fn/4 in Kernel.ParallelCompiler.spawn_compilers/1
# ** (CompileError)  compile error
#     (iex) lib/iex/helpers.ex:178: IEx.Helpers.c/2
