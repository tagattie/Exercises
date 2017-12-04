defmodule Stack.Supervisor do
  use Supervisor

  def start_link(initial_stack) do
    {:ok, sup_pid} = Supervisor.start_link(__MODULE__, [initial_stack])
    start_workers(sup_pid, initial_stack)
  end

  def start_workers(sup_pid, initial_stack) do
    # start a stash worker
    {:ok, stash_pid} =
      Supervisor.start_child(sup_pid, worker(Stack.Stash, [initial_stack]))
    # start a supervisor for stack server
    Supervisor.start_child(sup_pid,
      supervisor(Sequence.SubSupervisor, [stash_pid]))
  end

  def init(_) do
    supervise [], strategy: :one_for_one
  end
end

defmodule Sequence.SubSupervisor do
  use Supervisor

  def start_link(stash_pid) do
    {:ok, _pid } = Supervisor.start_link(__MODULE__, stash_pid)
  end

  def init(stash_pid) do
    child_processes = [ worker(Stack.Server, [stash_pid]) ]
    supervise child_processes, strategy: :one_for_one
  end
end
