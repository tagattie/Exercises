defmodule Stack.Server do
  use GenServer

  ##### External API
  #
  def start_link(stash_pid) do
    GenServer.start_link __MODULE__, stash_pid, name: __MODULE__
  end

  def initialize(list) do
    GenServer.cast __MODULE__, { :initialize, list }
  end

  def pop do
    GenServer.call __MODULE__, :pop
  end

  def push(element) do
    GenServer.cast __MODULE__, { :push, element }
  end

  ##### GenServer implementation
  #
  def init(stash_pid) do
    current_stack = Stack.Stash.get_value stash_pid
    { :ok, {current_stack, stash_pid} }
  end

  def handle_cast({:initialize, list}, { _current_stack, stash_pid }) do
    { :noreply, { list, stash_pid} }
  end

  def handle_call(:pop, _from, {_list = [head | tail], stash_pid}) do
    { :reply, head, { tail, stash_pid} }
  end

  def handle_cast({:push, top}, { list, stash_pid}) do
    { :noreply, { [ top | list ], stash_pid} }
  end

  def terminate(_reason, {current_stack, stash_pid}) do
    Stack.Stash.save_value stash_pid, current_stack
    # IO.puts "reason: #{inspect reason}"
    # IO.puts "state: #{inspect state}"
  end
end
