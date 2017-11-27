defmodule NoaaObs.HttpClient do

  def fetch(loc) do
    data_url(loc)
    |> HTTPoison.get()
    |> process_response
  end

  def data_url(loc) do
    "http://w1.weather.gov/xml/current_obs/#{loc}.xml"
  end

  def process_response({ :ok, %{status_code: 200, body: body }}) do
    { :ok, body }
  end

  def process_response({ _, %{status_code: _, body: body }}) do
    { :error, body }
  end

end
