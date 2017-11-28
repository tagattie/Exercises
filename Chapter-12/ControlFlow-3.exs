# ■練習問題: ControlFlow-3
# 多くの組込み関数には二つの形式がある。xxx という形式は、{:ok, data} というタプルを
# 返し、xxx! という形式では、成功時にデータを返し、そうでなければ例外を発生する。
# しかし、いくつかの関数には xxx! という形式はない。
# 任意の引数をとる ok! という関数を書いてみよう。もし、パラメータが {ok:, data} という
# タプルであれば、data を返す。そうでなければ、パラメータの情報を含む例外を発生する。
# 関数はこんな感じで使えるだろう。
#   file = ok! File.open("somefile")

defmodule MyOK do
  def ok!(args) do
    case args do
      {:ok, data} -> data
      _ -> raise RuntimeError, message: "argument: #{inspect(args)}"
    end
  end
end
