defmodule FizzBuzz do
  def upto(n) when n > 0, do: 1..n |> Enum.map(&fizzbuzz/1)

  defp fizzbuzz(n), do: _fizzword(n, rem(n, 3), rem(n, 5))

  defp _fizzword(_n, 0, 0), do: "FizzBuzz"
  defp _fizzword(_n, 0, _), do: "Fizz"
  defp _fizzword(_n, _, 0), do: "Buzz"
  defp _fizzword(n, _, _), do: n
end

# iex(6)> c "fizzbuzz3.exs"
# warning: redefining module FizzBuzz (current version defined in memory)
#   fizzbuzz3.exs:1
#
# [FizzBuzz]
# iex(7)> FizzBuzz.upto(10)
# [1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz"]
# iex(8)> FizzBuzz.upto(20)
# [1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11, "Fizz", 13, 14,
#  "FizzBuzz", 16, 17, "Fizz", 19, "Buzz"]
