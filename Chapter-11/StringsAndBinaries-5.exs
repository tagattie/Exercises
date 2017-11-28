# ■練習問題: StringAndBinaries-5
# ダブルクオート文字列のリストを取り、それぞれ別々の行で出力する関数を作ってみよう。
# 各行の文字列は、最も長い文字列の幅にセンタリングして出力すること。それから、UTF
# 文字できちんと動くこと。
# iex> center(["cat", "zebra", "elephant"])
#   cat
#  zebra
# elephant

defmodule MyString do

  def center(words) do
    words_with_length = count_length(words)
    max_length = check_max_length(words_with_length, 0)
    for n <- words_with_length do
      w = String.pad_leading(n.word, n.length + div(max_length - n.length, 2))
      IO.puts "#{inspect(w)}"
    end
  end

  def count_length([]), do: []
  def count_length(_words = [head | tail]) do
    [ %{word: head, length: String.length(head)} | count_length(tail) ]
  end

  def check_max_length([], length), do: length
  def check_max_length(words_with_length = [head | tail], length) do
    if head.length > length do
      check_max_length(tail, head.length)
    else
      check_max_length(tail, length)
    end
  end

end
