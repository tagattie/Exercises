defmodule MyEnum do
  def each(enumerable = [head | _tail], func) do
    func.(head)
    Enum.reduce(enumerable, fn(n, _acc) -> func.(n) end)
    :ok
  end

  def filter(enumerable, func) do
    Enum.reduce(enumerable, [], fn(n, acc) ->
      case func.(n) do
        true -> acc ++ [n]
        false -> acc
      end
    end)
  end

  def map(enumerable, func) do
    Enum.reduce(enumerable, [], fn(n, acc) -> acc ++ [func.(n)] end)
  end
end
