# ■練習問題: WorkingWithMultipleProcesses-2
# 二つのプロセスを生成し、それぞれのプロセスにユニークなトークン(例えば、"fred" とか
# "betty" とか)を渡すプログラムを作ろう。プロセスは、受け取ったトークンを送り返すよう
# にする。
# * プロセスから戻ってくる返事の順序は理論的に決定的であるか? 実際は?
# * もしその答えが「No」であるなら、どうすれば順序を決定的にできるだろうか?

defmodule Receiver do
  def recv_and_copy_token do
    receive do
      {sender, token} ->
        IO.puts "Received #{token} from #{inspect(sender)}"
        send sender, {:ok, "#{token}"}
    end
  end
end

defmodule Sender do
  def recv_and_print_token do
    receive do
      {:ok, message} -> IO.puts message
      recv_and_print_token()
    after 1000 -> IO.puts "Exitting..."
    end
  end
end

proc1 = spawn(Receiver, :recv_and_copy_token, [])
send proc1, {self(), "alpha"}
proc2 = spawn(Receiver, :recv_and_copy_token, [])
send proc2, {self(), "bravo"}

Sender.recv_and_print_token()

# iex(4)> c "WorkingWithMultipleProcesses-2.ex"
# warning: redefining module Receiver (current version defined in memory)
#   WorkingWithMultipleProcesses-2.ex:8
#
# warning: redefining module Sender (current version defined in memory)
#   WorkingWithMultipleProcesses-2.ex:18
#
# Received alpha from #PID<0.129.0>
# Received bravo from #PID<0.129.0>
# alpha
# bravo
# Exitting...
# [Sender, Receiver]
# iex(5)> c "WorkingWithMultipleProcesses-2.ex"
# warning: redefining module Receiver (current version defined in memory)
#   WorkingWithMultipleProcesses-2.ex:8
#
# warning: redefining module Sender (current version defined in memory)
#   WorkingWithMultipleProcesses-2.ex:18
#
# Received bravo from #PID<0.141.0>
# Received alpha from #PID<0.141.0>
# bravo
# alpha
# Exitting...
# [Sender, Receiver]
