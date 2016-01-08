defmodule ArrayTest do
  use ExUnit.Case
  import Parser.Array

  test "simple" do
    a = '[1,2,3]'
    assert parse(a) == {[1,2,3], ''}
  end
end
