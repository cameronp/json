defmodule Parser.String do
  import Map, except: [drop: 2]
  import Enum
  alias Parser.Char


  def capture(l) do
    case parse(l) do
      {s, rem} -> {s, rem}
      :error -> :error
    end
  end

  def parse(input) when is_list(input), do: parse_r(input)
  def parse(input), do: input |> to_char_list |> parse

  def parse_r(input) do
    s = %{input: input, result: [], started: false}
    forever
      |> reduce_while(s, fn _, state -> string_r(state.input, state) end)
      |> finish
  end

  def string_r([], s), do: {:halt, :error}
  def string_r([?" | res], s = %{started: false}),
    do: {:cont, s |> start |> set_input(res)}

  def string_r([?" | res], s), do: {:halt, s |> set_input(res)}

  def string_r(input, s = %{started: true}) do
    case Char.parse(input) do
      {c, res} -> {:cont, s |> add(c) |> set_input(res)}
      :error -> {:halt, :error}
    end
  end

  def string_r(_, s), do: {:halt, :error}


  def add(s,c), do: s |> put(:result, [c | s.result])
  def set_input(s, input), do: put(s, :input, input)

  def start(s), do: put(s, :started, true)
  def finish(:error), do: :error
  def finish(s), do: {s.result |> reverse |> to_string, s.input}

  def forever(), do: Stream.cycle([true])

end
