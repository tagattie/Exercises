# ■練習問題: MoreCoolStuff-2
# Float.parse 関数は、文字列の先頭の、数値に変換できる部分を浮動小数点数に
# 変換し、変換した値と残りの文字列を含むタプルか、:error というアトムを返す。
# CSV シジルを更新して、数値が自動的に変換されるようにしよう。
#   csv = ~v"""
#   1,2,3.14
#   cat,dog
#   """
# この場合、[[1.0,2.0,3.14], ["cat","dog"]] を返すようにしてほしい。

defmodule CSVSigil do
  def sigil_v(lines, _opts) do
    for l <- lines |> String.trim_trailing |> String.split("\n") do
      for t <- l |> String.split(",") do
        case Float.parse(t) do
          {num, _rem} -> num
          :error -> t
        end
      end
    end
  end
end

defmodule Test do
  import CSVSigil

  def csv do
    ~v"""
    1,2,3.14
    cat,dog
    """
  end
end

IO.inspect Test.csv
