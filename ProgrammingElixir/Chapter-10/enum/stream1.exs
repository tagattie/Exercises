[1,2,3,4]
|> Stream.map(&(&1*&1))
|> Stream.map(&(&1+1))
|> Stream.filter(fn x -> rem(x,2) == 1 end)
|> Enum.to_list
|> IO.inspect

# iex(22)> c "stream1.exs"
# [5, 17]
# []
