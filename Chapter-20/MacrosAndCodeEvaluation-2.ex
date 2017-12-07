# ■練習問題: MacrosAndCodeEvaluation-2
# 数値を一つ引数として取る、times_n というマクロを定義しよう。このマクロは、
# times_n という名前の関数を、呼び出したモジュールの中に定義する。定義された関数
# は、1つの引数をとり、それに n を掛けた値を返す。つまり、times_n(3)は times_3
# という関数を定義し、times_3(4)は 12 を返す。これが使い方の例だ。
#
# defmodule Test do
#   require Times
#   Times.times_n(3)
#   Times.times_n(4)
# end
#
# IO.puts Test.times_3(4)   #=> 12
# IO.puts Test.times_4(5)   #=> 20

defmodule Times do
  defmacro times_n(times) do
    funcname = "times_" <> to_string(times) |> String.to_atom
    quote do
      def unquote(funcname)(arg) do
        unquote(times) * arg
      end
    end
  end
end

defmodule Test do
  require Times
  Times.times_n(3)
  Times.times_n(4)
end

IO.puts Test.times_3(4)
IO.puts Test.times_4(5)

# iex(1)> c "MacrosAndCodeEvaluation-2.ex"
# 12
# 20
# [Test, Times]
