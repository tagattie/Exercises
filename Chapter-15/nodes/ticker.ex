defmodule Ticker do

  @interval 2000    # 2 seconds
  @name     :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), { :register, client_pid }
  end

  def generator(clients) do
    receive do
      { :register, pid } ->
        IO.puts "registering #{inspect pid}"
        generator([pid | clients])
    after
      @interval ->
        IO.puts "tick"
        Enum.each clients, fn client ->
          send client, { :tick }
        end
        generator(clients)
    end
  end
end

defmodule Client do

  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      { :tick } ->
        IO.puts "tock in client"
        receiver()
    end
  end
end

# □ウィンドウ1
# iex(one@alyeska)1> c "ticker.ex"
# [Client, Ticker]
# iex(one@alyeska)2> Node.connect :two@alyeska
# true
# iex(one@alyeska)3> Ticker.start
# :yes
# tick
# tick
# tick
# tick
# tick
# iex(one@alyeska)4> Client.start
# registering #PID<0.106.0>
# {:register, #PID<0.106.0>}
# tick
# tock in client
# tick
# tock in client
# tick
# tock in client
# tick
# tock in client
# tick
# tock in client
# registering #PID<12990.101.0>
# tick
# tock in client
# tick
# tock in client
# tick
# tock in client
# tick
# tock in client
# tick
# tock in client
# tick
# tock in client
# tick
# tock in client

# □ウィンドウ2
# iex(two@alyeska)1> c "ticker.ex"
# [Client, Ticker]
# iex(two@alyeska)2> Client.start
# {:register, #PID<0.101.0>}
# tock in client
# tock in client
# tock in client
# tock in client
# tock in client
# tock in client
