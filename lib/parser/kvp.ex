defmodule Parser.Kvp do
  import Enum
  import Map
  alias Parser.Key
  alias Parser.Value

  def capture(l), do: parse(l)

  def parse(input) when is_list(input), do: parse_r(input)
  def parse(input), do: input |> to_char_list |> parse

  def parse_r(l) do
    s = %{key: nil, value: nil, input: l}
    forever
    |> reduce_while(s, fn _, state -> kvp_r(state.input, state) end)
    |> finish
  end

  def kvp_r(input, s = %{key: nil}) do
    case Key.parse(input) do
      {key, tail} -> {:cont, s |> set_key(key) |> set_input(tail)}
      _ -> {:halt, :error}
    end
  end

  def kvp_r([?: | tail], s = %{colon: false}),
    do: {:cont, s |> set_colon(true) |> set_input(tail)}

  def kvp_r([?: | _tail], %{colon: true}), do: {:halt, :error}

  def kvp_r(input, s = %{value: nil}) do
    case Value.parse(input) do
      {value, tail} -> {:halt, s |> set_value(value) |> set_input(tail)}
      _ -> {:halt, :error}
    end
  end

  def set_key(s, key), do: put(s, :key, key) |> set_colon(false)
  def set_value(s, val), do: put(s, :value, val)
  def set_input(s, input), do: put(s, :input, input)
  def set_colon(s, bool), do: put(s, :colon, bool)

  def start(s), do: put(s, :started, true)
  def finish(:error), do: :error
  def finish(s), do: {put(%{}, s.key, s.value), s.input}

  def forever(), do: Stream.cycle([true])

end
