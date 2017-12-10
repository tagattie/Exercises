defprotocol Collection do
  @fallback_to_any true
  def is_collection?(value)
end

defimpl Collection, for: [List, Tuple, BitString, Map] do
  def is_collection?(_), do: true
end

defimpl Collection, for: Any do
  def is_collection?(_), do: false
end

Enum.each [ 1, 1.0, [1,2], {1,2}, %{}, "cat" ], fn value ->
  IO.puts "#{inspect value}:  #{Collection.is_collection?(value)}"
end

# iex(1)> c "is_collection.ex"
# 1:  false
# 1.0:  false
# [1, 2]:  true
# {1, 2}:  true
# %{}:  true
# "cat":  true
# [Collection.Any, Collection.Map, Collection.BitString, Collection.Tuple,
#  Collection.List, Collection]
