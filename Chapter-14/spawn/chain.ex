defmodule Chain do
  def counter(next_pid) do
    receive do
      n ->
        send next_pid, n + 1
    end
  end

  def create_processes(n) do
    last = Enum.reduce 1..n, self(),
             fn (_, send_to) ->
               spawn(Chain, :counter, [send_to])
             end

    # 0 を最後に作ったプロセスへ送り、カウントを開始
    send last, 0

    # 結果が戻ってくるまで待つ
    receive do
      final_answer when is_integer(final_answer) ->
        "Result is #{inspect(final_answer)}"
    end
  end

  def run(n) do
    IO.puts inspect :timer.tc(Chain, :create_processes, [n])
  end
end

# $ elixir -r chain.ex -e "Chain.run(10)"
# {8504, "Result is 10"}
# $ elixir -r chain.ex -e "Chain.run(100)"
# {14082, "Result is 100"}
# $ elixir -r chain.ex -e "Chain.run(1_000)"
# {27421, "Result is 1000"}
# $ elixir -r chain.ex -e "Chain.run(10_000)"
# {164740, "Result is 10000"}
# $ elixir -r chain.ex -e "Chain.run(100_000)"
# {1308794, "Result is 100000"}
# $ elixir --erl "+P 1000000" -r chain.ex -e "Chain.run(400_000)"
# {3882866, "Result is 400000"}
# $ elixir --erl "+P 1000000" -r chain.ex -e "Chain.run(1_000_000)"
# {56225907, "Result is 1000000"} <- seems my machine lacks enough memory for this X-(
