defmodule NoaaObs do
  @moduledoc """
  Get and display the latest weather observation data specified by
  location codes.
  """

  @targets [:station_id, :location, :weather, :temperature_string, :relative_humidity]

  import NoaaObs.CLI, only: [ parse_args: 1, process_args: 1 ]
  import NoaaObs.HttpClient, only: [ fetch: 1 ]
  import NoaaObs.XmlHandler, only: [ parse_xml: 1 ]
  import NoaaObs.TableFormatter, only: [ print_table_for_columns: 2 ]

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
    IO.puts "Result table:"
    print_table_for_columns(weathers, @targets)
  end
end
