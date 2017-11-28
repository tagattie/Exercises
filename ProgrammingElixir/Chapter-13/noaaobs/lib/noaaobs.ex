defmodule NoaaObs do
  @moduledoc """
  Get and display the latest weather observation data specified by
  location codes.
  """

  require Logger

  @targets [
    station_id: "Id",
    location: "Location",
    weather: "Weather",
    temp_c: "Temp(C)",
    relative_humidity: "RH(%)"
  ]

  import NoaaObs.CLI, only: [ parse_args: 1, process_args: 1 ]
  import NoaaObs.HttpClient, only: [ fetch: 1 ]
  import NoaaObs.XmlHandler, only: [ parse_xml: 2 ]
  import NoaaObs.TableFormatter, only: [ print_table_for_columns: 2 ]

  def main(argv) do
    locs = argv
    |> parse_args
    |> process_args
    Logger.info "List of location codes: #{inspect(locs)}"
    { targets, _headers } = Enum.unzip(@targets)
    weathers = for loc <- locs do
      fetch(loc)
      |> parse_xml(targets)
    end
    Logger.debug fn -> "Weather data of location codes: #{inspect(weathers)}" end
    IO.puts "Weather table:"
    print_table_for_columns(weathers, @targets)
  end
end
