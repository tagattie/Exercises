# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :noaaobs, data_url: "http://w1.weather.gov/xml/current_obs"
config :logger, compile_time_purge_level: :info

# You can configure your application as:
#
#     config :noaaobs, key: :value
#
# and access this configuration in your application as:
#
#     Application.get_env(:noaaobs, :key)
#
# You can also configure a 3rd-party app:
#
#     config :logger, level: :info
#
