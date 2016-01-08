defmodule KvpTest do
  use ExUnit.Case
  import Parser.Kvp

  test "string:string" do
    input = '"foo":"bar"'
    assert parse(input) == {%{foo: "bar"}, ''}
  end
end
