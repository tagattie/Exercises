# ■練習問題: WorkingWithMultipleProcesses-5
# 前二つの練習問題を、spawn_link から spawn_monitor に変えて繰り返してみよう。

defmodule ChildProc do
  def send_message(send_to, nth_child) do
    send(send_to,
      "Child process #{inspect(nth_child)} ID is #{inspect(self())}")
    # exit(:normal)
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

spawn_monitor(ChildProc, :send_message, [self(), 1])
spawn_monitor(ChildProc, :send_message, [self(), 2])
spawn_monitor(ChildProc, :send_message, [self(), 3])

:timer.sleep(500)
ParentProc.recv_message

# Normal exit
# $ elixir -r WorkingWithMultipleProcesses-5.ex
# Parent process ID is #PID<0.70.0>
# Message Received: "Child process 1 ID is #PID<0.79.0>"
# Message Received: {:DOWN, #Reference<0.0.3.32>, :process, #PID<0.79.0>, :normal}
# Message Received: "Child process 2 ID is #PID<0.80.0>"
# Message Received: {:DOWN, #Reference<0.0.3.33>, :process, #PID<0.80.0>, :normal}
# Message Received: "Child process 3 ID is #PID<0.81.0>"
# Message Received: {:DOWN, #Reference<0.0.3.34>, :process, #PID<0.81.0>, :normal}
# Parent process exits.

# Raise an exception
# $ elixir -r WorkingWithMultipleProcesses-5.ex
# Parent process ID is #PID<0.70.0>
#
# 20:46:23.022 [error] Process #PID<0.79.0> raised an exception
# ** (RuntimeError) something wrong!
#     WorkingWithMultipleProcesses-5.ex:9: ChildProc.send_message/2
#
# 20:46:23.029 [error] Process #PID<0.80.0> raised an exception
# ** (RuntimeError) something wrong!
#     WorkingWithMultipleProcesses-5.ex:9: ChildProc.send_message/2
#
# 20:46:23.030 [error] Process #PID<0.81.0> raised an exception
# ** (RuntimeError) something wrong!
#     WorkingWithMultipleProcesses-5.ex:9: ChildProc.send_message/2
# Message Received: "Child process 1 ID is #PID<0.79.0>"
# Message Received: "Child process 2 ID is #PID<0.80.0>"
# Message Received: "Child process 3 ID is #PID<0.81.0>"
# Message Received: {:DOWN, #Reference<0.0.2.275>, :process, #PID<0.79.0>, {%RuntimeError{message: "something wrong!"}, [{ChildProc, :send_message, 2, [file: 'WorkingWithMultipleProcesses-5.ex', line: 9]}]}}
# Message Received: {:DOWN, #Reference<0.0.2.276>, :process, #PID<0.80.0>, {%RuntimeError{message: "something wrong!"}, [{ChildProc, :send_message, 2, [file: 'WorkingWithMultipleProcesses-5.ex', line: 9]}]}}
# Message Received: {:DOWN, #Reference<0.0.2.277>, :process, #PID<0.81.0>, {%RuntimeError{message: "something wrong!"}, [{ChildProc, :send_message, 2, [file: 'WorkingWithMultipleProcesses-5.ex', line: 9]}]}}
# Parent process exits.
