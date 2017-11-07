defmodule Factorial do
  def of(0), do: 1
  def of(x) when x > 0 do
    x * of(x - 1)
  end
end

# iex(8)> Factorial.of(0)
# 1
# iex(9)> Factorial.of(1)
# 1
# iex(10)> Factorial.of(2)
# 2
# iex(11)> Factorial.of(10)
# 3628800
# iex(12)> Factorial.of(-1)
# ** (FunctionClauseError) no function clause matching in Factorial.of/1
#
#     The following arguments were given to Factorial.of/1:
#
#         # 1
#         -1
#
#     factorial2.exs:2: Factorial.of/1
