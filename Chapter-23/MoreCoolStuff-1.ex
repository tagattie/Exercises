# ■練習問題: MoreCoolStuff-1
# ~v というシジルを書いてみよう。これは複数行のカンマで区切られたデータを
# パースし、データの CSV 行のリストを返す。各 CSV 行は、カンマで区切られた
# 値のリストだ。クオートについては心配しないでもいい。単純に、各フィールド
# がカンマで区切られていると想定すればいい。
#   csv = ~v"""
#   1,2,3
#   cat,dog
#   """
# これが、[["1","2","3"], ["cat","dog"]] を返すようにする。

defmodule CSVSigil do
  def sigil_v(lines, _opts) do
    for l <- lines |> String.trim_trailing |> String.split("\n") do
      l |> String.split(",")
    end
  end
end

defmodule Test do
  import CSVSigil

  def csv do
    ~v"""
    1,2,3
    cat,dog
    """
  end
end

IO.inspect Test.csv
