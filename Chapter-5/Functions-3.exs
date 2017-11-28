# ■練習問題: Functions-3
# rem(a, b) という演算子は a を b で割った余りを返す関数だ。…

threeargs = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, c -> c
end

fizzbuzz = fn
  n -> threeargs.(rem(n, 3), rem(n, 5), n)
end

# iex(3)> fizzbuzz.(10)
# "Buzz"
# iex(4)> fizzbuzz.(11)
# 11
# iex(5)> fizzbuzz.(12)
# "Fizz"
# iex(6)> fizzbuzz.(13)
# 13
# iex(7)> fizzbuzz.(14)
# 14
# iex(8)> fizzbuzz.(16)
# 16 (入力打ち間違え)
# iex(9)> fizzbuzz.(15)
# "FizzBuzz"
# iex(10)> fizzbuzz.(16)
# 16
# iex(11)> fizzbuzz.(17)
# 17
