handle_open = fn
  {:ok, file}  -> "First line: #{IO.read(file, :line)}"
  {_,   error} -> "Error: #{:file.format_error(error)}"
end

# 存在するファイルを開く
IO.puts handle_open.(File.open("handle_open.exs"))
# そして、存在しないファイルを開こうとする
IO.puts handle_open.(File.open("nonexistent"))
