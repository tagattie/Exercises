# ■練習問題: StringsAndBinaries-4
# (難問) 「数字 [+-*/] 数字」という形のシングルクオート文字列を受け、その計算結果を返す
# 関数を書いてみよう。それぞれの数字は、プラスやマイナス記号がつかないものとする。
# calculate('123 + 27') # => 150

defmodule MyStrings do

  def calculate(formula), do: _calculate(formula, 0, 0, '')

  defp _calculate([], num1, num2, operator) when operator === ?+, do: num1 + num2
  defp _calculate([], num1, num2, operator) when operator === ?-, do: num1 - num2
  defp _calculate([], num1, num2, operator) when operator === ?*, do: num1 * num2
  defp _calculate([], num1, num2, operator) when operator === ?/, do: num1 / num2

  defp _calculate([head | tail], num1, num2, operator)
  when head in '0123456789' and operator === '' do
    _calculate(tail, num1*10 + head - ?0, num2, operator)
  end
  defp _calculate([head | tail], num1, num2, operator)
  when head in '0123456789' and operator !== '' do
    _calculate(tail, num1, num2*10 + head - ?0, operator)
  end
  defp _calculate([head | tail], num1, num2, operator)
  when head in '+-*/' and operator === '' do
    _calculate(tail, num1, num2, head)
  end
  defp _calculate([head | tail], num1, num2, operator)
  when head === ?\s do
    _calculate(tail, num1, num2, operator)
  end

end
