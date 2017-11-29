# ■練習問題: WorkingWithMultipleProcesses-4
# 同じように、しかし子プロセスが終了の代わりに例外を発生するようにしてみよう。何か出力に
# 違いはあるだろうか。

defmodule ChildProc do
  def send_message(send_to, nth_child) do
    send(send_to,
      "Child process #{inspect(nth_child)} ID is #{inspect(self())}")
    raise "something wrong!"
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

# $ elixir -r WorkingWithMultipleProcesses-4.ex
# Parent process ID is #PID<0.70.0>
# ** (EXIT from #PID<0.70.0>) an exception was raised:
#     ** (RuntimeError) something wrong!
#         WorkingWithMultipleProcesses-4.ex:9: ChildProc.send_message/2
#
#
# 20:41:15.504 [error] Process #PID<0.79.0> raised an exception
# ** (RuntimeError) something wrong!
#     WorkingWithMultipleProcesses-4.ex:9: ChildProc.send_message/2
#
# 20:41:15.509 [error] Process #PID<0.80.0> raised an exception
# ** (RuntimeError) something wrong!
#     WorkingWithMultipleProcesses-4.ex:9: ChildProc.send_message/2
#
# 20:41:15.509 [error] Process #PID<0.81.0> raised an exception
# ** (RuntimeError) something wrong!
#     WorkingWithMultipleProcesses-4.ex:9: ChildProc.send_message/2
