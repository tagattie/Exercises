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

defmodule Test do
  fifty = %Bitmap{value: 50}
  IO.puts Enum.count fifty
  IO.puts Enum.member? fifty, 4
  IO.puts Enum.member? fifty, 6
  IO.inspect Enum.reverse fifty
  IO.inspect Enum.join fifty, ":"
  list = fifty |> Enum.into []
  IO.inspect list
  Enum.into [0, 1, 1, 0, 0, 1, 0], %Bitmap{value: 0}
end

# iex(1)> c "bitmap_enumerable.ex"
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
#   bitmap_enumerable.ex:55
#
# 6
# true
# false
# [0, 1, 0, 0, 1, 1, 0]
# "0:1:1:0:0:1:0"
# [0, 1, 1, 0, 0, 1, 0]
#
# == Compilation error in file bitmap_enumerable.ex ==
# ** (Protocol.UndefinedError) protocol Collectable not implemented for %Bitmap{value: 0}
#     (elixir) lib/collectable.ex:1: Collectable.impl_for!/1
#     (elixir) lib/collectable.ex:77: Collectable.into/1
#     (elixir) lib/enum.ex:1173: Enum.into_protocol/2
#     bitmap_enumerable.ex:57: (module)
# ** (CompileError)  compile error
#     (iex) lib/iex/helpers.ex:178: IEx.Helpers.c/2
