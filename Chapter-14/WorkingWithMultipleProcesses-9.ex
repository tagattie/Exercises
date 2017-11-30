# ■練習問題: WorkingWithMultipleProcesses-9
# このスケジューラのコードを更新し、ディレクトリの中のファイルに "cat" という単語が
# 何個含まれているかを数えるプログラムを書いてみよう。ファイルごとにサーバプロセスを
# 作ろう。File.ls! がディレクトリ中のファイルを返し、File.read! がファイルの中身を
# バイナリで読み込む。より汎用化したスケジューラとして書くことができるだろうか?
# ほどほどの数のファイル(多分、100くらい)のあるディレクトリで、このコードを走らせて
# みよう。並行性の効果を体験できるだろう。

defmodule WordCounter do

  def count(sched_proc) do
    send sched_proc, { :ready, self() }
    receive do
      { :count, arg, sched_proc } ->
        send sched_proc,
          { :answer, arg, count_words(arg), self() }
        count(sched_proc)
      { :shutdown } ->
        exit(:normal)
    end
  end

  def count_words({ word, file }) do
    File.read!(file)
    |> String.split
    |> Enum.filter(fn(n) -> n == word end)
    |> Enum.count
  end

end

defmodule Scheduler do

  def run(num_processes, module, func, args) do
    (1..num_processes)
    |> Enum.map(fn(_) -> spawn(module, func, [self()]) end)
    |> schedule_processes(args, [])
  end

  defp schedule_processes(processes, args, results) do
    receive do
      { :ready, pid } when length(args) > 0 ->
        [ nextarg | tail ] = args
        send pid, { :count, nextarg, self() }
        schedule_processes(processes, tail, results)

      { :ready, pid } ->
        send pid, { :shutdown }
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), args, results)
        else
          Enum.sort(results, fn {n1,_}, {n2,_} -> n1 <= n2 end)
        end

      { :answer, arg, result, _pid } ->
        schedule_processes(processes, args, [ {arg, result} | results ])
    end
  end

end

count_word = "cat"

dirname = "textfiles"
args = File.ls!(dirname)
|> Enum.map(fn(filename) -> dirname <> "/" <> filename end)
|> Enum.map(fn(filename) -> { count_word, filename } end)
num_files = Enum.count(args)

{ time, results } = :timer.tc(
  Scheduler,
  :run, [num_files, WordCounter, :count, args]
)
results
|> Enum.map(fn({{word, filename}, count})
  -> IO.puts "#{word}, #{filename}, #{count}" end)
IO.puts "#{time/1000000}"
