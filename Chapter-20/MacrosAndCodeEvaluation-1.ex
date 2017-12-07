# ■練習問題: MacrosAndCodeEvaluation-1
# 標準の unless の機能を持つ myunless という名前のマクロを書こう。その中で if 式を
# 使ってもよい。

defmodule My do
  defmacro myunless(condition, clauses) do
    do_clause   = Keyword.get(clauses, :do, nil)
    else_clause = Keyword.get(clauses, :else, nil)
    quote do
      if !unquote(condition) do
        unquote(do_clause)
      else
        unquote(else_clause)
      end
    end
  end
end

defmodule Test do
  require My
  My.myunless 1 == 2 do
    IO.puts "1 != 2"
  else
    IO.puts "1 == 2"
  end
end

# iex(1)> c "MacrosAndCodeEvaluation-1.ex"
# 1 != 2
# [Test, My]
