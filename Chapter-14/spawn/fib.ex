defmodule FibSolver do

  def fib(scheduler) do
    send scheduler, { :ready, self() }
    receive do
      { :fib, n, client } ->
        send client, { :answer, n, fib_calc(n), self() }
        fib(scheduler)
      { :shutdown } ->
        exit(:normal)
    end
  end

  # 意図的に、とても非効率にしている
  defp fib_calc(0), do: 0
  defp fib_calc(1), do: 1
  defp fib_calc(n), do: fib_calc(n-1) + fib_calc(n-2)

end

defmodule Scheduler do

  def run(num_processes, module, func, to_calculate) do
    (1..num_processes)
    |> Enum.map(fn(_) -> spawn(module, func, [self()]) end)
    |> schedule_processes(to_calculate, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      { :ready, pid } when length(queue) > 0 ->
        [ next | tail ] = queue
        send pid, { :fib, next, self() }
        schedule_processes(processes, tail, results)

      { :ready, pid } ->
        send pid, { :shutdown }
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn {n1,_}, {n2,_} -> n1 <= n2 end)
        end

      { :answer, number, result, _pid } ->
        schedule_processes(processes, queue, [ {number, result} | results ])
    end
  end

end

to_process = [ 37, 37, 37, 37, 37, 37 ]

Enum.each 1..10, fn num_processes ->
  { time, result } = :timer.tc(
    Scheduler,
    :run, [num_processes, FibSolver, :fib, to_process]
  )

  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n #   time (s)"
  end
  :io.format "~2B     ~.2f~n", [num_processes, time/1000000.0]
end

# $ elixir fib.ex
# [{37, 24157817}, {37, 24157817}, {37, 24157817}, {37, 24157817}, {37, 24157817}, {37, 24157817}]
#
#  #   time (s)
#  1     6.36
#  2     4.25
#  3     3.25
#  4     3.28
#  5     3.25
#  6     2.88
#  7     2.98
#  8     3.02
#  9     2.92
# 10     2.92
