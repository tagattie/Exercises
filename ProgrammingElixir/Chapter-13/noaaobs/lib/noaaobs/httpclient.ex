defmodule NoaaObs.HttpClient do

  require Logger

  def fetch(loc) do
    Logger.info "Fetching weather data for #{inspect(loc)}"
    data_url(loc)
    |> HTTPoison.get()
    |> process_response
  end

  @data_url Application.get_env(:noaaobs, :data_url)
  def data_url(loc) do
    "#{@data_url}/#{loc}.xml"
  end

  def process_response({ :ok, %{status_code: 200, body: body }}) do
    Logger.debug "Successful response returned"
    Logger.debug fn -> inspect(body) end
    { :ok, body }
  end

  def process_response({ _, %{status_code: status, body: body }}) do
    Logger.error "Error #{status} returned"
    { :error, message = "Error #{status} returned" }
  end

end
