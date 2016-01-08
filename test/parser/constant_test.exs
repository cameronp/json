defmodule ConstantTest do
  use ExUnit.Case

  import Parser.Constant

  test "see's true" do
    s = 'true '
    assert parse(s) == {true, ' '}
  end

  test "see's false" do
    s = 'false ]'
    assert parse(s) == {false, ' ]'}
  end

  test "see's null" do
    s = 'null }'
    assert parse(s) == {nil, ' }'}
  end

  test "no more constants" do
    s = 'nil '
    assert parse(s) == :error
  end

  test "capture" do
    s = 'null }'
    assert capture(s) == {{:constant, nil}, ' }'}
  end

end
