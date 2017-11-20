# ■練習問題: StringsAndBinaries-6
# 文字列にある文をキャピタライズする関数を書いてみよう。それぞれの文はピリオドと
# 1文字のスペースで終わる。今のところ、文字の大文字小文字はランダムとなっている。
# iex> capitalize_sentences("oh. a DOG. woof. ")
# "Oh. A dog. Woof. "

defmodule MyString do
  def capitalize_sentences(string), do: _capitalize_sentences(string, "", 1)

  defp _capitalize_sentences(string = <<head::utf8, tail::binary>>, capped_string, 1)
  when head !== ?\s and head !== ?. do
    capped_string = capped_string <> String.upcase(String.first(string))
    _capitalize_sentences(tail, capped_string, 0)
  end
  defp _capitalize_sentences(string = <<head::utf8, tail::binary>>, capped_string, 0)
  when head === ?. do
    capped_string = capped_string <> String.first(string)
    _capitalize_sentences(tail, capped_string, 0.5)
  end
  defp _capitalize_sentences(string = <<head::utf8, tail::binary>>, capped_string, 0.5)
  when head === ?\s do
    capped_string = capped_string <> String.first(string)
    _capitalize_sentences(tail, capped_string, 1)
  end
  defp _capitalize_sentences(string = <<_head::utf8, tail::binary>>, capped_string, _cap_flag) do
    capped_string = capped_string <> String.downcase(String.first(string))
    _capitalize_sentences(tail, capped_string, 0)
  end
  defp _capitalize_sentences("", capped_string, _cap_flag), do: IO.puts "#{inspect(capped_string)}"

end

MyString.capitalize_sentences("oh. a DOG. woof. ")
