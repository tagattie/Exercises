defmodule Spawn2 do
  def greet do
    receive do
      {sender, msg} -> send sender, {:ok, "Hello, #{msg}"}
    end
  end
end

# ここからクライアント
pid = spawn(Spawn2, :greet, [])

send pid, {self, "World!"}

receive do
  {:ok, message} -> IO.puts message
end

send pid, {self, "Kermit!"}

receive do
  {:ok, message} -> IO.puts message
end

# iex(1)> c "spawn2.ex"
# warning: variable "self" does not exist and is being expanded to "self()", please use parentheses to remove the ambiguity or change the variable name
#   spawn2.ex:12

# warning: variable "self" does not exist and is being expanded to "self()", please use parentheses to remove the ambiguity or change the variable name
#   spawn2.ex:18

# Hello, World!

# BREAK: (a)bort (c)ontinue (p)roc info (i)nfo (l)oaded
#        (v)ersion (k)ill (D)b-tables (d)istribution
# ^C
