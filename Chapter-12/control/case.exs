case File.open("case.exs") do
  { :ok, file } -> IO.puts "First.line #{IO.read(file, :line)}"
  { :error, reason } -> IO.puts "Failed to open file: #{reason}"
end

# 開くファイル名が case.ex のとき
# iex(9)> c "case.exs"
# Failed to open file: enoent
# []

# 開くファイル名が case.exs のとき
# iex(10)> c "case.exs"
# First.line case File.open("case.exs") do
#
# []
