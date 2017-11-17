# ■練習問題: StringsAndBinaries-1
# シングルクオート文字列が、印字可能な ASCII 文字(スペースからチルダまで)だけを含む場合に、true を返す関数を書いてみよう。

defmodule MyStrings do

  def printable?(list), do: _printable?(list, true)

  defp _printable?([], value), do: value
  defp _printable?(_list = [head | tail], value)
  when 32 <= head and head <= 126 do
    _printable?(tail, value and true)
  end
  defp _printable?(_list = [_head | tail], value) do
    _printable?(tail, value and false)
  end

end

# iex(11)> c "StringsAndBinaries-1.exs"
# warning: redefining module MyStrings (current version defined in memory)
#   StringsAndBinaries-1.exs:4

# [MyStrings]
# iex(12)> MyStrings.printable?('abcde')
# true
# iex(13)> MyStrings.printable?('123')
# true
# iex(14)> MyStrings.printable?('123\x01')
# false
