# ■練習問題: ListsAndRecursion-8
# プラグマティック・ブックシェルフ社は、テキサス(TX)とノースカロライナ(NC)にオフィスがある。…

orders = [
  [ id: 123, ship_to: :NC, net_amount: 100.00 ],
  [ id: 124, ship_to: :OK, net_amount:  35.50 ],
  [ id: 125, ship_to: :TX, net_amount:  24.00 ],
  [ id: 126, ship_to: :TX, net_amount:  44.80 ],
  [ id: 127, ship_to: :NC, net_amount:  25.00 ],
  [ id: 128, ship_to: :MA, net_amount:  10.00 ],
  [ id: 129, ship_to: :CA, net_amount: 102.00 ],
  [ id: 130, ship_to: :NC, net_amount:  50.00 ]
]

defmodule MyList do

  def copy(list) do
    tax_rates = [ NC: 0.075, TX: 0.08 ]

    for item <- list do
      if item[:ship_to] === :NC or item[:ship_to] === :TX do
        Keyword.put_new(item, :total_amount, item[:net_amount]*(1+tax_rates[item[:ship_to]]))
      else
        Keyword.put_new(item, :total_amount, item[:net_amount])
      end
    end
  end
end

IO.inspect MyList.copy orders

# iex(69)> c "ListsAndRecursion-8.exs"
# warning: redefining module MyList (current version defined in memory)
#   ListsAndRecursion-8.exs:15
#
# [[total_amount: 107.5, id: 123, ship_to: :NC, net_amount: 100.0],
#  [total_amount: 35.5, id: 124, ship_to: :OK, net_amount: 35.5],
#  [total_amount: 25.92, id: 125, ship_to: :TX, net_amount: 24.0],
#  [total_amount: 48.384, id: 126, ship_to: :TX, net_amount: 44.8],
#  [total_amount: 26.875, id: 127, ship_to: :NC, net_amount: 25.0],
#  [total_amount: 10.0, id: 128, ship_to: :MA, net_amount: 10.0],
#  [total_amount: 102.0, id: 129, ship_to: :CA, net_amount: 102.0],
#  [total_amount: 53.75, id: 130, ship_to: :NC, net_amount: 50.0]]
# [MyList]
