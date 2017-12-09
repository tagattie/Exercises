# ■練習問題: MacrosAndCodeEvaluation-3
# Elixir のテストフレームワークである ExUnit は、コードを quote する賢いトリックを
# 使っている。例えば、こう assert したとき、
#   assert 5 < 4
# "expected 5 to be less than 4." というエラーを得るはずだ。
# Elixir のソースコードは GitHub (https://github.com/elixir-lang/elixir)にある。
# この実装は、elixir/lib/ex_unit/assertions.ex だ。このファイルをしばらく読んでみよ
# う。そして、どのようにこのトリックを実装しているか考えてみよう。
# (難問)それが終わったら、同じテクニックを使って、任意の算術式を受け取り、それを自然言語に
# して返す関数を実装できないか、考えてみよう。
#   explain do: 2 + 3 * 4
#   #=> multiply 3 and 4, then add 2

defmodule Ex do
  @operator [:+, :-, :*, :/]

  defmacro explain(do: expr) do
    translate_expr(quote do: unquote(expr))
  end

  def translate_expr({operator, _, [left, right]} = _expr)
  when operator in @operator
  and is_number(left)
  and is_number(right) do
    case operator do
      :+ ->
        "add #{left} and #{right}"
      :- ->
        "subtract #{right} from #{left}"
      :* ->
        "multiply #{left} and #{right}"
      :/ ->
        "divide #{left} by #{right}"
    end
  end

  def translate_expr({operator, _, [left, right]} = _expr)
  when operator in @operator
  and is_number(left)
  and is_tuple(right) do
    msg = translate_expr(right)
    case operator do
      :+ ->
        msg <> ", then add #{left}"
      :- ->
        msg <> ", then subtract #{left}"
      :* ->
        msg <> ", then multiply #{left}"
      :/ ->
        msg <> ", then divide by #{left}"
    end
  end

  def translate_expr({operator, _, [left, right]})
  when operator in @operator
  and is_tuple(left)
  and is_number(right) do
    msg = translate_expr(left)
    case operator do
      :+ ->
        msg <> ", then add #{right}"
      :- ->
        msg <> ", then subtract #{right}"
      :* ->
        msg <> ", then multiply #{right}"
      :/ ->
        msg <> ", then divide by #{right}"
    end
  end

  def translate_expr({operator, _, [left, right]})
  when operator in @operator
  and is_tuple(left)
  and is_tuple(right) do
    msg_l = translate_expr(left)
    msg_r = translate_expr(right)
    msg = msg_l <> ", " <> msg_r
    case operator do
      :+ ->
        msg <> ", then add them"
      :- ->
        msg <> ", then subtract the latter from the former"
      :* ->
        msg <> ", then multiply them"
      :/ ->
        msg <> ", then divide the former by the latter"
    end
  end
end
