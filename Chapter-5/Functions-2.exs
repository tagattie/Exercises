# ■練習問題: Functions-2
# 引数を三つとる関数を書こう。…

threeargs = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, c -> c
end
