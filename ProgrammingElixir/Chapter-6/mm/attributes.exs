defmodule Example do
  @author "Dave Thomas"
  def get_author do
    @author
  end
end

IO.puts "Example was writtern by #{Example.get_author}"

# iex(3)> c "attributes.exs"
# warning: redefining module Example (current version defined in memory)
#   attributes.exs:1
#
# Example was writtern by Dave Thomas
# [Example]
