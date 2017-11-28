defmodule Spawn1 do
  def greet do
    receive do
      { sender, msg } -> send sender, { :ok, "Hello, #{msg}" }
    end
  end
end

# ここからクライアント
pid = spawn(Spawn1, :greet, [])
send pid, { self, "World!" }

receive do
  {:ok, message} -> IO.puts message
end

# iex(1)> c "spawn1.ex"
# [Spawn1]
# iex(2)> pid = spawn(Spawn1, :greet, [])
# #PID<0.89.0>
# iex(3)> send pid, { self, "World!" }
# {#PID<0.81.0>, "World!"}
# iex(4)> receive do
# ...(4)> {:ok, message} -> IO.puts message
# ...(4)> end
# Hello, World!
# :ok
