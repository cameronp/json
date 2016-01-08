defmodule Parser.Char do

  def capture(l), do: parse(l)

  def parse(input) when is_list(input), do: parse_r(input)
  def parse(input), do: input |> to_char_list |> parse

  def parse_r('\\t' ++ tail), do: {?\t, tail}
  def parse_r('\\n' ++ tail), do: {?\n, tail}
  def parse_r('\\b' ++ tail), do: {?\b, tail}
  def parse_r('\\/' ++ tail), do: {?/, tail}
  def parse_r('\\\\' ++ tail), do: {?\\, tail}
  def parse_r('\\"' ++ tail), do: {?", tail}
  def parse_r([c | tail]), do: {c, tail}

end
