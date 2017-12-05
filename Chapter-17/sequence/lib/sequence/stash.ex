defmodule Sequence.Stash do
  use GenServer
  require Logger

  @vsn "1"

  defmodule StashState do
    defstruct current_number: 0, current_delta: 1
  end

  ##### 外部 API
  #
  def start_link(current_number) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, current_number)
  end

  def save_value(pid, current_number, current_delta) do
    GenServer.cast pid, {:save_value, {current_number, current_delta}}
  end

  def get_value(pid) do
    GenServer.call pid, :get_value
  end

  ##### GenServer の実装
  #
  def init(current_number) do
    { :ok, %StashState{current_number: current_number} }
  end

  def handle_call(:get_value, _from, state) do
    { :reply, { state.current_number, state.current_delta }, state }
  end

  def handle_cast({:save_value, {current_number, current_delta}}, state) do
    { :noreply, %{ state | current_number: current_number, current_delta: current_delta } }
  end

  def code_change("0", old_state = current_number, _extra) do
    new_state = %StashState{current_number: current_number,
                            current_delta: 1
                            }
    Logger.info "Changing code from 0 to 1"
    Logger.info inspect(old_state)
    Logger.info inspect(new_state)
    { :ok, new_state }
  end
end
