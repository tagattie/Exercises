# ■練習問題: Protocols-2
# 単語のリストを使って、rot13(word)がそのリストに含まれているような単語を探す
# プログラムを書こう(様々な英単語のリストが http://wordlist.sourceforge.net/
# で紹介されている。SCOWL コレクションは使えそうだ。すでに、サイズごとに分割さ
# れている)。

defprotocol Caesar do
  def encrypt(string, shift)
  def rot13(string)
end

defimpl Caesar, for: List do
  def encrypt(string, shift) do
    string
    |> Enum.map(fn (n) ->
      cond do
        ?A <= n and n <= ?Z ->
          if n + shift > ?Z do
            n + shift - (?Z-?A+1)
          else
            n + shift
          end
        ?a <= n and n <= ?z ->
          if n + shift > ?z do
            n + shift - (?z-?a+1)
          else
            n + shift
          end
        true -> n
      end
    end)
  end
  def rot13(string) do
    encrypt(string, 13)
  end
end

defimpl Caesar, for: BitString do
  def encrypt(string, shift) do
    string
    |> to_charlist
    |> Caesar.List.encrypt(shift)
    |> to_string
  end
  def rot13(string) do
    encrypt(string, 13)
  end
end

defmodule Rot13Search do
  def search(filename) do
    words_list = File.read!(filename)
    |> String.split
    |> MapSet.new
    # IO.puts "#{inspect words_list}"
    rot13_list = words_list
    |> Enum.map(fn(n) -> Caesar.rot13(n) end)
    |> MapSet.new
    # IO.puts "#{inspect rot13_list}"
    for n <- _answer_list = MapSet.intersection(words_list, rot13_list)
    |> MapSet.to_list
    |> Enum.sort do
      IO.puts "#{n} -> #{Caesar.rot13(n)}"
    end
  end
end

Rot13Search.search("english-words")
