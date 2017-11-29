defmodule Parallel do
  def pmap(collection, fun) do
    me = self()
    collection
    |> Enum.map(fn (elem) ->
      spawn_link fn -> (send me, { self(), fun.(elem) }) end
    end)
    |> Enum.map(fn (pid) ->
      receive do { ^pid, result } -> result end
    end)
  end
end

# iex(1)> c "pmap.ex"
# [Parallel]
# iex(2)> Parallel.pmap 1..10, &(&1*&1)
# [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
# iex(3)> Parallel.pmap 1..100, &(&1*&1)
# [1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, 169, 196, 225, 256, 289, 324,
#  361, 400, 441, 484, 529, 576, 625, 676, 729, 784, 841, 900, 961, 1024, 1089,
#  1156, 1225, 1296, 1369, 1444, 1521, 1600, 1681, 1764, 1849, 1936, 2025, 2116,
#  2209, 2304, 2401, 2500, ...]
