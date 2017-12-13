defmodule Catch do

  def start(n) do
    try do
      incite(n)
    catch
      :exit, code   -> "Exited with code #{inspect code}"
      :throw, value -> "throw called with #{inspect value}"
      what, value   -> "Caught #{inspect what} with #{inspect value}"
    end
  end

  defp incite(1) do
    exit(:somthing_bad_happened)
  end

  defp incite(2) do
    throw {:animal, "wombat"}
  end

  defp incite(3) do
    :erlang.error "Oh no!"
  end
end

# iex(1)> c "catch.ex"
# [Catch]
# iex(2)> Catch.start 1
# "Exited with code :somthing_bad_happened"
# iex(3)> Catch.start 2
# "throw called with {:animal, \"wombat\"}"
# iex(4)> Catch.start 3
# "Caught :error with \"Oh no!\""
