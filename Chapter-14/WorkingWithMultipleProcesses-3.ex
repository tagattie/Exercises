# ■練習問題: WorkingWithMultipleProcesses-3
# spawn_link を使ってプロセスを生成し、そのプロセスで親プロセスへメッセージを送信した後、
# すぐに終了するようにしてみよう。その間、親プロセスでは 500ミリ秒スリープし、その後で、受
# 信を待機しているメッセージをすべて受信するようにしよう。何を受信するか、調査してほしい。
# 子プロセスが終了するとき、子プロセスからの通知を待っていないことが問題になるだろうか?

defmodule ChildProc do
  def send_message(send_to, nth_child) do
    send(send_to,
      "Child process #{inspect(nth_child)} ID is #{inspect(self())}")
    exit(:normal)
  end
end

defmodule ParentProc do
  def recv_message do
    receive do
      msg ->
        IO.puts "Message Received: #{inspect(msg)}"
      recv_message()
    after 2000 ->
        IO.puts "Parent process exits."
    end
  end
end

IO.puts "Parent process ID is #{inspect(self())}"

spawn_link(ChildProc, :send_message, [self(), 1])
spawn_link(ChildProc, :send_message, [self(), 2])
spawn_link(ChildProc, :send_message, [self(), 3])

:timer.sleep(500)
ParentProc.recv_message

# $ elixir -r WorkingWithMultipleProcesses-3.ex
# Parent process ID is #PID<0.70.0>
# Message Received: "Child process 1 ID is #PID<0.79.0>"
# Message Received: "Child process 2 ID is #PID<0.80.0>"
# Message Received: "Child process 3 ID is #PID<0.81.0>"
# Parent process exits.
