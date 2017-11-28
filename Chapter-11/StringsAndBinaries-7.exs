# ■練習問題: StringsAndBinaries-7
# 第 10 章で、「税金を計算する練習問題」(p.106)があった。今、ファイルにカンマで
# 区切られた id, ship_to そして総額という販売情報がある。ファイルはこんな感じだ。
#   id,ship_to,net_amount
#   123,:NC,100.00
#   124,:OK,35.50
#   125,:TX,24.00
#   126,:TX,44.80
#   127,:NC,25.00
#   128,:MA,10.00
#   129,:CA,102.00
#   130,:NC,50.00
# このファイルを読み、パースして、sales_tax 関数にパースした結果を渡す関数を書い
# てみよう。データはキーワードリストに整形しなければならず、それぞれのフィールドが
# 適切な型でなければならない(id フィールドは整数、といったように)ことを心に留めて
# おこう。
# File.open, IO.read(file, :line), そして IO.stream(file)といったライブ
# ラリ関数が必要になるだろう。

defmodule MyString do

  def parse_sales_data_file(filename) do
    {:ok, file} = File.open(filename)
    kw_list = IO.read(file, :line)
    |> String.trim("\n")
    |> String.split(",")
    kw_atom_list = for kw <- kw_list do
      String.to_atom(kw)
    end

    for line <- IO.stream(file, :line) do
      [id, ship_to, net_amount] = String.trim(line, "\n")
      |> String.split(",")
      l = [String.to_integer(id),
           String.trim(ship_to, ":") |> String.to_atom(),
           String.to_float(net_amount)]
      order = Enum.zip(kw_atom_list, l)
    end
  end

end
