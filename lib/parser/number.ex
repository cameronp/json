defmodule Parser.Number do
  import Map

  def capture(input) do
    case parse(input) do
      :error -> :error
      {val, remaining} -> {val, remaining}
    end
  end

  def parse(input) when is_list(input), do: parse(to_string(input))
  def parse(input), do: Integer.parse(input) |> finish

  def finish(:error), do: :error
  def finish({val, rem}), do: {val, to_char_list(rem)}
end
