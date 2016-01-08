defmodule ValueTest do
  use ExUnit.Case
  import Parser.Value

  test "matches string" do
    s = '"foobar"'
    assert parse(s) == {"foobar", ''}
  end

  test "matches number" do
    n = '256,43'
    assert parse(n) == {256, ',43'}
  end

  test "matches constant" do
    c = 'trueenough'
    assert parse(c) == {{:constant, true}, 'enough'}
  end

  test "doesn't match object" do
    o = '{ myval: 2}'
    assert parse(o) == :error
  end

end
