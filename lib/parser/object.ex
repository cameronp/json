defmodule Parser.Object do
  import Enum
  import Map
  alias Parser.Kvp

  @start_delimeter ?{
  @stop_delimeter ?}
  @separator ?,
  @whitespace [?\s, ?\t, ?\n]

  def capture(l), do: parse(l)

  def parse(l) when is_list(l) do
    s = %{input: l, result: %{}, started: false}
    forever
    |> reduce_while(s, fn _, state -> object_r(state.input, state) end)
    |> finish
  end

  def object_r([], s), do: {:halt, :error}
  def object_r([ @stop_delimeter | res], s), do: {:halt, s |> set_input(res)}
  def object_r([ @start_delimeter | res], s = %{result: %{}} ), do: {:cont, s |> set_input(res) |> start}
  def object_r([@separator, @separator | _r], s), do: {:halt, :error}
  def object_r([ @separator | res], s), do: {:cont, s |> set_input(res)}
  def object_r([ w | res], s) when w in @whitespace, do: {:cont, s |> set_input(res)}

  def object_r(input, s = %{started: true}) do
    case Kvp.capture(input) do
      {kvp, res} -> {:cont, add(s, kvp) |> set_input(res)}
      :error -> {:halt, :error}
    end
  end



  def object_r(input, s), do: {:halt, :error}

  def add(s, kvp), do: put(s, :result, merge(s.result, kvp))
  def set_input(s, input), do: put(s, :input, input)

  def start(s), do: put(s, :started, true)
  def finish(:error), do: :error
  def finish(s), do: {s.result, s.input}

  def forever(), do: Stream.cycle([true])

end
