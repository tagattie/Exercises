defmodule WeatherHistory do

  def for_location([], _target_loc), do: []
  def for_location([ [time, target_loc, temp, rain ] | tail ], target_loc) do
    [ [time, target_loc, temp, rain] | for_location(tail, target_loc) ]
  end
  def for_location([ _ | tail ], target_loc), do: for_location(tail, target_loc)

  def test_data do
    [
      [1366225622, 26, 15, 0.125],
      [1366225622, 27, 15, 0.45],
      [1366225622, 28, 21, 0.25],
      [1366229222, 26, 19, 0.081],
      [1366229222, 27, 17, 0.468],
      [1366229222, 28, 15, 0.60],
      [1366232822, 26, 22, 0.095],
      [1366232822, 27, 21, 0.05],
      [1366232822, 28, 24, 0.03],
      [1366236422, 26, 17, 0.025]
    ]
  end
end

# iex(4)> c "weather2.exs"
# warning: redefining module WeatherHistory (current version defined in memory)
#   weather2.exs:1
#
# [WeatherHistory]
# iex(5)> import WeatherHistory
# WeatherHistory
# iex(6)> for_location(test_data, 27)
# [[1366225622, 27, 15, 0.45], [1366229222, 27, 17, 0.468],
#  [1366232822, 27, 21, 0.05]]
# iex(7)> for_location(test_data, 26)
# [[1366225622, 26, 15, 0.125], [1366229222, 26, 19, 0.081],
#  [1366232822, 26, 22, 0.095], [1366236422, 26, 17, 0.025]]
