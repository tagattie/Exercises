IO.puts File.stream!("words") |> Enum.max_by(&String.length/1)

# iex(2)> c "stream3.exs"
# antidisestablishmentarianism
#
# []
