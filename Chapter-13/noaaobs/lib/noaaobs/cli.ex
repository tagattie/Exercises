defmodule NoaaObs.CLI do

  @default_loc_list ["KLAX"]

  @doc """
  `argv` can be -h or --help, which returns :help. Otherwise,
  it is (an optional) list of location codes.

  Return a list of `loccode`, or `:help` when help is given.
  """
  def parse_args(argv) do
    args = OptionParser.parse(argv,
      switches: [ help: :boolean, debug: :boolean ],
      aliases:  [ h:    :help,    d:     :debug ])
    case args do
      { [ help: true ], _, _ }  -> :help
      # { [ debug: true ], _, _ } -> :debug
      { _, [], _ } -> @default_loc_list
      { _, list, _ } -> list
    end
  end

  def process_args(:help) do
    IO.puts """
    Usage: noaaobs [<loccode> ...]
    """
    System.halt(0)
  end

  def process_args(codelist) do
    codelist
  end

end
