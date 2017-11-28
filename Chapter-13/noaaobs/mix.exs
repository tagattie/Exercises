defmodule NoaaObs.Mixfile do
  use Mix.Project

  def project do
    [
      app: :noaaobs,
      escript: escript_config(),
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:httpoison],
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      { :httpoison, "~> 0.8"   }
    ]
  end

  defp escript_config do
    [ main_module: NoaaObs ]
  end
end
