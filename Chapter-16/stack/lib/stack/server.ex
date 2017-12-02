defmodule Stack.Server do
  use GenServer

  def handle_call(:initialize, _from, list) do
    { :reply, :ok, list }
  end

  def handle_call(:pop, _from, _list = [head | tail]) do
    { :reply, head, tail }
  end

  def handle_cast({:push, top}, list) do
    { :noreply, [ top | list ] }
  end
end
