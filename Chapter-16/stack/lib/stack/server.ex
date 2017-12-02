defmodule Stack.Server do
  use GenServer

  def handle_call(:initialize, _from, list) do
    { :reply, :ok, list }
  end

  def handle_call(:pop, _from, _list = [head | tail]) do
    { :reply, head, tail }
  end
end
