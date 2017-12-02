defmodule Stack.Server do
  use GenServer

  def start_link(list) do
    GenServer.start_link __MODULE__, list, name: __MODULE__
  end

  def pop do
    GenServer.call __MODULE__, :pop
  end

  def push(element) do
    GenServer.cast __MODULE__, { :push, element }
  end

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
