defmodule Sequence do
  use Application

  def start(_type, initial_number) do
    import Supervisor.Spec, warn: false

    {:ok, _pid} = Sequence.Supervisor.start_link(initial_number)
  end
end
