defmodule Subscriber do
  defstruct name: "", paid: false, over_18: true
end

# iex(18)> c "defstruct.exs"
# [Subscriber]
# iex(19)> s1 = %Subscriber{}
# %Subscriber{name: "", over_18: true, paid: false}
# iex(20)> s2 = %Subscriber{ name: "Dave" }
# %Subscriber{name: "Dave", over_18: true, paid: false}
# iex(21)> s3 = %Subscriber{ name: "Mary", paid: true }
# %Subscriber{name: "Mary", over_18: true, paid: true}
# iex(22)> s3.name
# "Mary"
# iex(23)> %Subscriber{name: a_name} = s3
# %Subscriber{name: "Mary", over_18: true, paid: true}
# iex(24)> a_name
# "Mary"
# iex(25)> s4 = %Subscriber{ s3 | name: "Marie" }
# %Subscriber{name: "Marie", over_18: true, paid: true}
