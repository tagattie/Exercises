defmodule Customer do
  defstruct name: "", company: ""
end

defmodule BugReport do
  defstruct owner: %Customer{}, details: "", severity: 1
end

# iex(34)> c "nested.exs"
# [BugReport, Customer]
# iex(35)> report = %BugReport{owner: %Customer{name: "Dave", company: "Pragmatic"}, details: "broken"}
# %BugReport{details: "broken",
#  owner: %Customer{company: "Pragmatic", name: "Dave"}, severity: 1}
# iex(36)> report.owner.company
# "Pragmatic"
# iex(37)> report = %BugReport{report | owner: %Customer{report.owner | company: "PragProg"}}
# %BugReport{details: "broken",
#  owner: %Customer{company: "PragProg", name: "Dave"}, severity: 1}
# iex(38)> put_in(report.owner.company, "PragProg")
# %BugReport{details: "broken",
#  owner: %Customer{company: "PragProg", name: "Dave"}, severity: 1}
# iex(39)> update_in(report.owner.name, &("Mr. " <> &1))
# %BugReport{details: "broken",
#  owner: %Customer{company: "PragProg", name: "Mr. Dave"}, severity: 1}
