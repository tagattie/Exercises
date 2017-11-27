defmodule NoaaObs do
  @moduledoc """
  Get and display the latest weather observation data specified by
  location codes.
  """

  import NoaaObs.CLI, only: [ parse_args: 1, process_args: 1 ]

  def main(argv) do
    locs = argv
    |> parse_args
    |> process_args

    IO.puts "List of loccodes:"
    IO.puts "#{inspect(locs)}"
  end
end
