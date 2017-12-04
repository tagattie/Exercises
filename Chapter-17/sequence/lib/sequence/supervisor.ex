defmodule Sequence.Supervisor do
  use Supervisor

  def start_link(initial_number) do
    result = {:ok, sup} = Supervisor.start_link(__MODULE__, [initial_number])
    start_workers(sup, initial_number)
    result
  end

  def start_workers(sup, initial_number) do
    # スタッシュワーカーを開始
    {:ok, stash} =
      Supervisor.start_child(sup, worker(Sequence.Stash, [initial_number]))
    # そして、実際の sequence サーバのスーパーバイザを開始
    Supervisor.start_child(sup, supervisor(Sequence.SubSupervisor, [stash]))
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
    child_processes = [ worker(Sequence.Server, [stash_pid]) ]
    supervise child_processes, strategy: :one_for_one
  end
end
