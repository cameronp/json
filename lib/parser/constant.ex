defmodule Parser.Constant do

  def capture(input) do
    case parse(input) do
      :error -> :error
      {val, remaining} -> {{:constant, val}, remaining}
    end
  end

  def parse(l) when is_list(l), do: parse_r(l)
  def parse(l), do: l |> to_char_list |> parse

  def parse_r(input) do
    case input do
      'true' ++ tail -> {true, tail}
      'false' ++ tail -> {false, tail}
      'null' ++ tail -> {nil, tail}
      _ -> :error
    end
  end

end
