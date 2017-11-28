IO.puts File.open!("/usr/share/dict/words")
|> IO.stream(:line)
|> Enum.max_by(&String.length/1)

# iex(1)> c "stream2.exs"
# antidisestablishmentarianism
#
# []
