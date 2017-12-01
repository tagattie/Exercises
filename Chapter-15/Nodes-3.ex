# ■練習問題: Nodes-3
# 登録されたクライアントが順々に通知を受け取るようにコードを変更しよう。つまり、最初の時報が
# 最初に登録されたクライアントに届き、次の時報が次のクライアントに届き、……(以下同じ)となる
# ようにする。最後のクライアントへ送った後は、また最初に戻る。解答のコードでも、クライアント
# をいつでも追加できなければならない。

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
        if length(clients) > 0 do
          [ next | tail ] = clients
          send next, { :tick }
          generator(tail ++ [next])
        else
          generator(clients)
        end
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
