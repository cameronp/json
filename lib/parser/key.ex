defmodule Parser.Key do

  def capture(l), do: parse(l)

  def parse(input) when is_list(input), do: parse_r(input)
  def parse(input), do: input |> to_char_list |> parse

  def parse_r(l) do
    case Parser.String.parse(l) do
      {key, rest} -> {String.to_atom(key), rest}
      _ -> :error
    end
  end
end
