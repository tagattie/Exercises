# Useful URLs
# https://medium.com/@blogscot/parsing-xml-using-elixir-mostly-f1368593b0ca
# http://rustamagasanov.com/blog/2015/10/19/parse-xml-with-elixir-and-xmerl-example/
# https://qiita.com/mserizawa/items/9ab40fecba88e429ac9e

defmodule NoaaObs.XmlHandler do

  import Record, only: [ defrecord: 2, extract: 2 ]
  defrecord :xmlElement,
    extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
  defrecord :xmlText,
    extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl")

  @targets [:station_id, :location, :weather, :temperature_string, :relative_humidity]

  def parse_xml({:ok, body}) do
    {xmldoc, _} = body
    |> :binary.bin_to_list
    |> :xmerl_scan.string
    :xmerl_xpath.string('//current_observation', xmldoc)
    |> parse_weather
  end

  def parse_xml({:error, _body}) do
    # {xmldoc, _} = body
    # |> :binary.bin_to_list
    # |> :xmerl_scan.string([space: :normalize])
    # HTML document returned for non-existent location seems invalid.
    # Only to put "XML parse error"
    [{ :error, "XML parse error" }]
  end

  def parse_weather([weather]) do
    Enum.map(@targets,
      fn(target) ->
        [node] = :xmerl_xpath.string('//' ++ to_charlist(target), weather)
        [text] = xmlElement(node, :content)
        value = xmlText(text, :value)
        { target, value }
      end)
  end

end
