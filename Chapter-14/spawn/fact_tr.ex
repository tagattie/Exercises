defmodule TailRecursive do
  def factorial(n), do: _fact(n, 1)
  defp _fact(0, acc), do: acc
  defp _fact(n, acc), do: _fact(n-1, acc*n)
end

# iex(1)> c "fact_tr.ex"
# [TailRecursive]
# iex(2)> TailRecursive.factorial(10)
# 3628800
# iex(3)> TailRecursive.factorial(100)
# 93326215443944152681699238856266700490715968264381621468592963895217599993229915608941463976156518286253697920827223758251185210916864000000000000000000000000
