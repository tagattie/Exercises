# ■練習問題: StringsAndBinaries-2
# パラメータがアナグラムだったら true を返す anagram?(word1, word2) という関数を書いてみよう。

defmodule MyStrings do

  def anagram?(word1, word2) when length(word1) !== length(word2), do: false
  def anagram?(word1, word2), do: Enum.sort(word1) === Enum.sort(word2)

end
