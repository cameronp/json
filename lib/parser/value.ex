defmodule Parser.Value do
  import Enum, only: [find_value: 2 ]

  alias Parser.String
  alias Parser.Number
  alias Parser.Constant
  alias Parser.Array
  alias Parser.Object


  def capture(l), do: parse(l)

  def parse(l) when is_list(l) do
    [&String.capture/1, &Number.capture/1, &Constant.capture/1, &Array.capture/1, &Object.capture/1]
    |> find_value(fn cap ->
         case cap.(l) do
           :error -> false
           result -> result
         end
       end)
    |> default_to(:error)
  end

  def default_to(val, default), do: val || default

end
