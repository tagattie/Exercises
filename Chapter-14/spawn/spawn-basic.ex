defmodule SpawnBasic do
  def greet do
    IO.puts "Hello"
  end
end

# iex(1)> c "spawn-basic.ex"
# [SpawnBasic]
# iex(2)> SpawnBasic.greet
# Hello
# :ok
# iex(3)> spawn(SpawnBasic, :greet, [])
# Hello
# #PID<0.90.0>
