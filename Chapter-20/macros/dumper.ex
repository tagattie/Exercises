defmodule My do
  defmacro macro(param) do
    IO.inspect param
  end
end

defmodule Test do
  require My

  # これらの値はその値がそのまま表現となる
  My.macro :atom
  My.macro 1
  My.macro 1.0
  My.macro [1,2,3]
  My.macro "binaries"
  My.macro {1, 2}
  My.macro do: 1

  # そしてこれらは三つ組のタプルで表現される

  My.macro {1,2,3,4,5}

  My.macro do: (a = 1; a+a)

  My.macro do
    1+2
  else
    3+4
  end

end

# iex(1)> c "dumper.ex"
# :atom
# 1
# 1.0
# [1, 2, 3]
# "binaries"
# {1, 2}
# [do: 1]
# {:{}, [line: 21], [1, 2, 3, 4, 5]}
# [do: {:__block__, [],
#   [{:=, [line: 23], [{:a, [line: 23], nil}, 1]},
#    {:+, [line: 23], [{:a, [line: 23], nil}, {:a, [line: 23], nil}]}]}]
# [do: {:+, [line: 26], [1, 2]}, else: {:+, [line: 28], [3, 4]}]
# [Test, My]
