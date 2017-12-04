defmodule Sequence do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    {:ok, _pid} = Sequence.Supervisor.start_link(Application.get_env(:sequence, :initial_number))
  end
end
