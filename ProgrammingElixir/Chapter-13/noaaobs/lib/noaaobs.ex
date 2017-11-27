defmodule NoaaObs do
  @moduledoc """
  Get and display the latest weather observation data specified by
  location codes.
  """

  import NoaaObs.CLI, only: [ parse_args: 1, process_args: 1 ]
  import NoaaObs.HttpClient, only: [ fetch: 1 ]

  def main(argv) do
    locs = argv
    |> parse_args
    |> process_args
    IO.puts "List of loccodes:"
    IO.puts "#{inspect(locs)}"
    for loc <- locs do
      weather = fetch(loc)
      IO.puts "Weather of #{loc}"
      IO.puts "#{inspect(weather)}"
    end
  end
end
