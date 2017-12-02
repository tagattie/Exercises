# ■練習問題: Nodes-4
# この章で紹介した通知プロセスは、登録されたクライアントにイベントを送る中央サーバだった。
# これを、クライアントのリング(輪)として再実装しよう。クライアントは通知をリング上の次のク
# ライアントに送る。その 2秒後に、先ほど通知を受け取ったクライアントは次のクライアントに通
# 知を送る。
# リングにクライアントを加える方法について考えるときは、新しいプロセスを加えるときと同じよ
# うに、クライアントの受信ループがタイムアウトした場合の取り扱いについても留意しよう。どう
# いうことかというと、「誰がリンクの更新の責任を追うのか?」という問題だ。

defmodule Ticker do

  @name :ticker

  def start do
    pid = spawn(__MODULE__, :registrar, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), { :register, client_pid }
  end

  def registrar([]) do
    receive do
      { :register, pid } ->
        IO.puts "1st client: #{inspect pid}"
        send pid, { :next, pid }
        IO.puts "send initial tick to #{inspect pid}"
        send pid, { :tick }
        registrar([pid])
    end
  end
  def registrar(clients) do
    receive do
      { :register, pid } ->
        IO.puts "New client: #{inspect pid}"
        send List.first(clients), { :next, pid }
        send pid, { :next, List.last(clients) }
        registrar([pid | clients])
    end
  end

end

defmodule Client do

  @interval 2000

  def start do
    pid = spawn(__MODULE__, :wait_next, [])
    Ticker.register(pid)
  end

  def wait_next do
    receive do
      { :next, pid } ->
        IO.puts "Link update: #{inspect self()} -> #{inspect pid}"
        ticker(pid)
      _ ->
        wait_next()
    end
  end

  def ticker(next) do
    receive do
      { :next, pid } ->
        IO.puts "Link update: #{inspect self()} -> #{inspect pid}"
        ticker(pid)
      { :tick } ->
        IO.puts "Received tick: #{inspect self()} @ #{inspect :erlang.time()}"
        :timer.sleep @interval
        send next, { :tick }
        ticker(next)
    end
  end

end
