defmodule Boom do
  def start(n) do
    try do
      raise_error(n)
    rescue
      [ FunctionClauseError, RuntimeError ] ->
        IO.puts "no function match or runtime error"
      error in [ArithmeticError] ->
        IO.inspect error
        IO.puts "Uh-oh! Arithmetic error"
        reraise "too late, we're doomed", System.stacktrace
      other_errors ->
        IO.puts "Disaster! #{inspect other_errors}"
    after
      IO.puts "DONE!"
    end
  end

  defp raise_error(0) do
    IO.puts "No error"
  end

  defp raise_error(val = 1) do
    IO.puts "About to divide by zero"
    1 / (val - 1)
  end

  defp raise_error(2) do
    IO.puts "About to call a function that doesn't exist"
    raise_error(99)
  end

  defp raise_error(3) do
    IO.puts "About to try creating a directory with no permission"
    File.mkdir!("/not_allowed")
  end
end

# iex(1)> c "exception.ex"
# [Boom]
# iex(2)> Boom.start 1
# About to divide by zero
# %ArithmeticError{message: "bad argument in arithmetic expression"}
# Uh-oh! Arithmetic error
# DONE!
# ** (RuntimeError) too late, we're doomed
#     exception.ex:25: Boom.raise_error/1
#     exception.ex:4: Boom.start/1
# iex(2)> Boom.start 2
# About to call a function that doesn't exist
# no function match or runtime error
# DONE!
# :ok
# iex(3)> Boom.start 3  <<<<< Windows doesn't throw exception in this case
# About to try creating a directory with no permission
# DONE!
# :ok
