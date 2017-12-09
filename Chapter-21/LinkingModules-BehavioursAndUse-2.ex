# ■練習問題: LinkingModules-BehavioursAndUse-2
# 組込み関数の IO.ANSI.escape は ANSI エスケープシーケンスを文字列に挿入する。挿入
# された文字列をターミナルに出力する際に、色や太字、反転、アンダーラインといった効果を
# つけることができる。
#   iex(1)> IO.puts IO.ANSI.format(["Hello, ", :inverse, :bright, "world!"], true)
#   Hello, world!
# ライブラリを調査しよう。IO.ANSI.format の返り値は何になるだろうか。そして、その
# 返り値を IO.puts に渡すと、なぜ動くのだろうか。
# それから IO.ANSI.format を使って、トレースの出力を色付けしてみよう。

defmodule Tracer do
  def dump_args(args) do
    args |> Enum.map(&inspect/1) |> Enum.join(", ")
  end

  def dump_defn(name, args) do
    "#{name}(#{dump_args(args)})"
  end

  defmacro def(definition = {name, _, args}, do: content) do
    quote do
      Kernel.def(unquote(definition)) do
        IO.puts IO.ANSI.format([:yellow, "==> call:   ", :green, "#{Tracer.dump_defn(unquote(name), unquote(args))}"], true)
        result = unquote(content)
        IO.puts IO.ANSI.format([:yellow, "<== result: ", :blue, "#{result}"], true)
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
end

Test.puts_sum_three(1,2,3)
Test.add_list([5,6,7,8])
