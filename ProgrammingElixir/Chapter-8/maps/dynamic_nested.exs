nested = %{
  buttercup: %{
    actor: %{
      first: "Robin",
      last:  "Wright"
    },
    role: "princess"
  },
  westley: %{
    actor: %{
      first: "Carey",
      last:  "Ewes"
    },
    role: "farm boy"
  }
}

IO.inspect get_in(nested, [:buttercup])
IO.inspect get_in(nested, [:buttercup, :actor])
IO.inspect get_in(nested, [:buttercup, :actor, :first])
IO.inspect put_in(nested, [:westley, :actor, :last], "Elwes")

# iex(45)> c "dynamic_nested.exs"
# %{actor: %{first: "Robin", last: "Wright"}, role: "princess"}
# %{first: "Robin", last: "Wright"}
# "Robin"
# %{buttercup: %{actor: %{first: "Robin", last: "Wright"}, role: "princess"},
#   westley: %{actor: %{first: "Carey", last: "Elwes"}, role: "farm boy"}}
# []
