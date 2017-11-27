defmodule NoaaObs do
  @moduledoc """
  Get and display the latest weather observation data specified by
  location codes.
  """

  import NoaaObs.CLI, only: [ parse_args: 1, process_args: 1 ]
  import NoaaObs.HttpClient, only: [ fetch: 1 ]
  import NoaaObs.XmlHandler, only: [ parse_xml: 1 ]

  def main(argv) do
    locs = argv
    |> parse_args
    |> process_args
    IO.puts "List of loccodes: #{inspect(locs)}"
    weathers = for loc <- locs do
      fetch(loc)
      |> parse_xml
    end
    IO.puts "Weather data: #{inspect(weathers)}"
  end
end
