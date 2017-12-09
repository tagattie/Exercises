# ■練習問題: LinkingModules-BehavioursAndUse-3
# (難問)ガード節のある関数定義を Test モジュールに加えてみよう、トレースがうまく
# いかないことが分かるだろう。
# ・うまくいかない理由を見つけよう。
# ・修正方法があるか考えよう。

# {:def, [context: Elixir, import: Kernel],
#  [{:when, [context: Elixir],
#    [{:func_with_guard, [],
#      [{:a, [], Elixir}, {:b, [], Elixir}, {:c, [], Elixir}]},
#     {:and, [context: Elixir, import: Kernel],
#      [{:and, [context: Elixir, import: Kernel],
#        [{:>, [context: Elixir, import: Kernel], [{:a, [], Elixir}, 0]},
#         {:>, [context: Elixir, import: Kernel], [{:b, [], Elixir}, 0]}]},
#       {:>, [context: Elixir, import: Kernel], [{:c, [], Elixir}, 0]}]}]},
#   [do: {:*, [context: Elixir, import: Kernel],
#     [{:a, [], Elixir}, {:a, [], Elixir}]}]]}


defmodule Tracer do
  def dump_args(args) do
    args |> Enum.map(&inspect/1) |> Enum.join(", ")
  end

  defmacro dump_cond(conditions) do
    Macro.to_string(conditions)
  end

  def dump_defn(name, args) do
    "#{name}(#{dump_args(args)})"
  end

  defmacro def(definition = {guard, _, [{name, _, args}, conditions]},
               do: content) do
    quote do
      Kernel.def(unquote(definition)) do
        IO.puts "==> call:   #{Tracer.dump_defn(unquote(name), unquote(args))} #{unquote(guard)} #{Tracer.dump_cond(unquote(conditions))}"
        result = unquote(content)
        IO.puts "<== result: #{result}"
        result
      end
    end
  end

  defmacro def(definition = {name, _, args}, do: content) do
    quote do
      Kernel.def(unquote(definition)) do
        IO.puts "==> call:   #{Tracer.dump_defn(unquote(name), unquote(args))}"
        result = unquote(content)
        IO.puts "<== result: #{result}"
        result
      end
    end
  end

  defmacro __using__(_opts) do
    quote do
      import Kernel, except: [def: 2]
      import unquote(__MODULE__), only: [def: 2]
    end
  end
end

defmodule Test do
  use Tracer
  def puts_sum_three(a, b, c), do: IO.inspect(a + b + c)
  def add_list(list),          do: Enum.reduce(list, 0, &(&1+&2))
  def puts_sum_three_with_guard(a, b, c) when a > 0 and b > 0 and c > 0 do
    IO.inspect(a + b + c)
  end
end

Test.puts_sum_three(1,2,3)
Test.add_list([5,6,7,8])
Test.puts_sum_three_with_guard(1,2,3)

# ・うまくいかない理由を見つけよう。
# 関数を定義するタプルが、ガード節の有無によって変わるため、もとのマクロではうまく
# いかない。ガード節があるときにマッチするマクロを用意すればうまくいくと思うが。
# iex(1)> quote do: def func(a,b,c), do: a+b+c
# {:def, [context: Elixir, import: Kernel],
#  [{:func, [context: Elixir],
#    [{:a, [], Elixir}, {:b, [], Elixir}, {:c, [], Elixir}]},
#   [do: {:+, [context: Elixir, import: Kernel],
#     [{:+, [context: Elixir, import: Kernel],
#       [{:a, [], Elixir}, {:b, [], Elixir}]}, {:c, [], Elixir}]}]]}
# iex(2)> quote do: def func(a,b,c) when a>0 and b>0 and c>0, do: a+b+c
# {:def, [context: Elixir, import: Kernel],
#  [{:when, [context: Elixir],
#    [{:func, [], [{:a, [], Elixir}, {:b, [], Elixir}, {:c, [], Elixir}]},
#     {:and, [context: Elixir, import: Kernel],
#      [{:and, [context: Elixir, import: Kernel],
#        [{:>, [context: Elixir, import: Kernel], [{:a, [], Elixir}, 0]},
#         {:>, [context: Elixir, import: Kernel], [{:b, [], Elixir}, 0]}]},
#       {:>, [context: Elixir, import: Kernel], [{:c, [], Elixir}, 0]}]}]},
#   [do: {:+, [context: Elixir, import: Kernel],
#     [{:+, [context: Elixir, import: Kernel],
#       [{:a, [], Elixir}, {:b, [], Elixir}]}, {:c, [], Elixir}]}]]}
