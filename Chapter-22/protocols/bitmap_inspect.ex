defmodule Bitmap do
  defstruct value: 0

  @doc """
  A simple accessor for the 2^bit value in an integer

    iex> b = %Bitmap{value: 5}
    %Bitmap{value: 5}
    iex> Bitmap.fetch_bit(b, 2)
    1
    iex> Bitmap.fetch_bit(b, 1)
    0
    iex> Bitmap.fetch_bit(b, 0)
    1
  """
  def fetch_bit(%Bitmap{value: value}, bit) do
    use Bitwise

    (value >>> bit) &&& 1
  end

  defimpl Inspect do
    def inspect(%Bitmap{value: value}, _opts) do
      "%Bitmap{#{value}=#{as_binary(value)}}"
    end
    defp as_binary(value) do
      to_string(:io_lib.format("~.2B", [value]))
    end
  end
end

defimpl Enumerable, for: Bitmap do
  import :math, only: [log: 1]

  def count(%Bitmap{value: value}) do
    { :ok, trunc(log(abs(value))/log(2)) + 1 }
  end

  def member?(value, bit_number) do
    { :ok, 0 <= bit_number && bit_number < Enum.count(value) }
  end

  def reduce(bitmap, {:cont, acc}, fun) do
    bit_count = Enum.count(bitmap)
    _reduce({bitmap, bit_count}, {:cont, acc}, fun)
  end
  defp _reduce({_bitmap, -1}, {:cont, acc}, _fun), do: {:done, acc}
  defp _reduce({bitmap, bit_number}, {:cont, acc}, fun) do
    with bit = Bitmap.fetch_bit(bitmap, bit_number),
    do: _reduce({bitmap, bit_number-1}, fun.(bit, acc), fun)
  end
  defp _reduce({_bitmap, _bit_number}, {:halt, acc}, _fun), do: {:halted, acc}
  defp _reduce({bitmap, bit_number}, {:suspend, acc}, fun),
  do: {:suspended, acc, &_reduce({bitmap, bit_number}, &1, fun), fun}
end

defimpl Collectable, for: Bitmap do
  use Bitwise

  def into(%Bitmap{value: target}) do
    {target, fn
      acc, {:cont, next_bit} -> (acc <<< 1) ||| next_bit
      acc, :done             -> %Bitmap{value: acc}
      _, :halt               -> :ok
    end}
  end
end

defmodule Test do
  fifty = %Bitmap{value: 50}
  IO.puts Enum.count fifty
  IO.puts Enum.member? fifty, 4
  IO.puts Enum.member? fifty, 6
  IO.inspect Enum.reverse fifty
  IO.inspect Enum.join fifty, ":"
  list = fifty |> Enum.into []
  IO.inspect list
  bit = Enum.into [0, 1, 1, 0, 0, 1, 0], %Bitmap{value: 0}
  IO.inspect bit

  IO.inspect fifty
  IO.inspect fifty, structs: false
end

# iex(1)> c "bitmap_inspect.ex"
# warning: parentheses are required when piping into a function call. For example:
#
#
#     foo 1 |> bar 2 |> baz 3
#
# is ambiguous and should be written as
#
#     foo(1) |> bar(2) |> baz(3)
#
# Ambiguous pipe found at:
#   bitmap_inspect.ex:76
#
# 6
# true
# false
# [0, 1, 0, 0, 1, 1, 0]
# "0:1:1:0:0:1:0"
# [0, 1, 1, 0, 0, 1, 0]
# %Bitmap{50=110010}
# %Bitmap{50=110010}
# %{__struct__: Bitmap, value: 50}
# [Test, Collectable.Bitmap, Enumerable.Bitmap, Bitmap, Inspect.Bitmap]
# iex(2)> %Bitmap{value: 12345678901234567890}
# %Bitmap{12345678901234567890=1010101101010100101010011000110011101011000111110000101011010010}
