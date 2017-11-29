defmodule Monitor1 do
  import :timer, only: [ sleep: 1 ]

  def sad_function do
    sleep 500
    exit(:boom)
  end

  def run do
    res = spawn_monitor(Monitor1, :sad_function, [])
    IO.puts inspect res
    receive do
      msg ->
        IO.puts "MESSAGE RECEIVED: #{inspect msg}"
    after 1000 ->
        IO.puts "Nothing happened as far as I am concerned"
    end
  end
end

Monitor1.run

# $ elixir -r monitor1.ex
# {#PID<0.78.0>, #Reference<0.176142531.3364880387.61445>}
# MESSAGE RECEIVED: {:DOWN, #Reference<0.176142531.3364880387.61445>, :process, #PID<0.78.0>, :boom}
