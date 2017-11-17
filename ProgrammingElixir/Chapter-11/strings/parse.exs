defmodule Parse do

  def number([ ?- | tail ]), do: _number_digits(tail, 0) * -1
  def number([ ?+ | tail ]), do: _number_digits(tail, 0)
  def number(str),           do: _number_digits(str, 0)

  defp _number_digits([], value), do: value
  defp _number_digits([ digit | tail ], value)
  when digit in '0123456789' do
    _number_digits(tail, value*10 + digit - ?0)
  end
  defp _number_digits([ non_digit | _ ], _) do
    raise "Invalid digit '#{[non_digit]}'"
  end

end

# iex(1)> c "parse.exs"
# [Parse]
# iex(2)> Parse.number('123')
# 123
# iex(3)> Parse.number('-123')
# -123
# iex(4)> Parse.number('+123')
# 123
# iex(5)> Parse.number('+9')
# 9
# iex(6)> Parse.number('+a')
# ** (RuntimeError) Invalid digit 'a'
#     parse.exs:13: Parse._number_digits/2
