authors = [
  %{ name: "Jose",  language: "Elixir" },
  %{ name: "Matz",  language: "Ruby" },
  %{ name: "Larry", language: "Perl" }
]

language_with_an_r = fn (:get, collection, next_fn) ->
  for row <- collection do
    if String.contains?(row.language, "r") do
      next_fn.(row)
    end
  end
end

IO.inspect get_in(authors, [language_with_an_r, :name])
IO.inspect get_in(authors, [language_with_an_r, :language])

# iex(46)> c "get_in_func.exs"
# ["Jose", nil, "Larry"]
# []
