defmodule MyEnum do
  # Enum.all?(list, func)
  def all?(list, func), do: _all?(list, func, true)

  defp _all?(_list = [head | tail], func, flag) do
    flag and _all?(tail, func, func.(head))
  end
  defp _all?([], _, flag), do: flag

  # Enum.each(list, func)
  def each(_list = [head | tail], func) do
    [ func.(head) | each(tail, func) ]
  end
  def each([], _), do: []

  # Enum.filter(list, func)
  def filter(_list = [head | tail], func) do
    if func.(head) do
      [head | filter(tail, func)]
    else
      filter(tail, func)
    end
  end
  def filter([], _), do: []

  # Enum.split(list, num)
  def split(list, num) when num >= 0, do: _split([], list, num)

  defp _split(list1, list2 = [head | tail], num) when num > 0 do
    _split(list1 ++ [head], tail, num - 1)
  end
  defp _split(list1, list2, 0), do: {list1, list2}
  defp _split(list1, [], _), do: {list1, []}

end
