defmodule NoaaObs.HttpClient do

  require Logger

  def fetch(loc) do
    Logger.info "Fetching weather data for #{inspect(loc)}"
    data_url(loc)
    |> HTTPoison.get()
    |> process_response
  end

  def data_url(loc) do
    "http://w1.weather.gov/xml/current_obs/#{loc}.xml"
  end

  def process_response({ :ok, %{status_code: 200, body: body }}) do
    Logger.debug "Successful response returned"
    Logger.debug fn -> inspect(body) end
    { :ok, body }
  end

  def process_response({ _, %{status_code: status, body: body }}) do
    Logger.error "Error #{status} returned"
    { :error, body }
  end

end
