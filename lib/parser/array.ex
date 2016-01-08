defmodule Parser.Array do
  import Enum
  import Map
  alias Parser.Value

  @start_delimeter ?[
  @stop_delimeter ?]
  @separator ?,
  @whitespace [?\s, ?\t, ?\n]


  def capture(l), do: parse(l)

  def parse(l) when is_list(l) do
    s = %{input: l, result: [], started: false}
    forever
    |> reduce_while(s, fn _, state -> array_r(state.input, state) end)
    |> finish
  end


  def array_r([], s), do: {:halt, :error}
  def array_r([ @stop_delimeter | res], s), do: {:halt, s |> set_input(res)}
  def array_r([ @start_delimeter | res], s = %{started: false} ), do: {:cont, s |> set_input(res) |> start}
  def array_r([ @separator, @separator | _r], s), do: {:halt, :error}
  def array_r([ @separator | res], s), do: {:cont, s |> set_input(res)}
  def array_r([ w | res], s) when w in @whitespace, do: {:cont, s |> set_input(res)}

  def array_r(input, s = %{started: true}) do
    case Value.capture(input) do
      {v, res} -> {:cont, add(s, v) |> set_input(res)}
      :error -> s
    end
  end

  def array_r(_input, _s), do: {:halt, :error}

  def add(s, val), do: put(s, :result, [val | s.result])
  def set_input(s, input), do: put(s, :input, input)

  def start(s), do: put(s, :started, true)
  def finish(:error), do: :error
  def finish(s), do: {reverse(s.result), s.input}

  def forever(), do: Stream.cycle([true])
end
