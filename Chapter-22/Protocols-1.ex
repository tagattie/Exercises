# ■練習問題: Protocols-1
# 基本的なシーザー暗号は、メッセージの文字を固定のオフセットの分だけシフトすることで
# 成立している。オフセットが 1なら、例えば a は b に、b は c に、そして z は a に
# なる。オフセットが 13のものは、ROT13 アルゴリズムとして知られている。
# リストとバイナリはどちらも文字列のようなものだ。この二つの形に対応するシーザープロ
# トコルを書こう。作成するプロトコルには、二つの関数 encrypt(string, shift) と
# rot13(string) を含めよう。

defprotocol Caesar do
  def encrypt(string, shift)
  def rot13(string)
end

defimpl Caesar, for: List do
  def encrypt(string, shift) do
    string
    |> Enum.map(fn (n) ->
      if n + shift > ?z do
        n + shift - (?z-?a+1)
      else
        n + shift
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

# iex(1)> c "Protocols-1.ex"
# [Caesar.BitString, Caesar.List, Caesar]
# iex(2)> Caesar.encrypt('cat', 5)
# 'hfy'
# iex(3)> Caesar.rot13('cat')
# 'png'
# iex(4)> Caesar.encrypt("cat", 5)
# "hfy"
# iex(5)> Caesar.rot13("cat")
# "png"
