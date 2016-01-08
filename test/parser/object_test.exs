defmodule ObjectTest do
  use ExUnit.Case
  import Parser.Object

  test "simple" do
    o = '{ "foo":12 }'
    assert parse(o) == {%{foo: 12}, ''}
  end

  test "string string" do
    o = '{ "foo":"bar" }'
    assert parse(o) == {%{foo: "bar"}, ''}
  end

  test "array attrib" do
    o = '{ "foo":[1,2,3] }'
    assert parse(o) == {%{foo: [1,2,3]}, ''}
  end

  test "nested obj" do
    o = '{ "foo":{ "bar":3} }'
    assert parse(o) == {%{foo: %{bar: 3}}, ''}
  end

  test "invalid" do
    e = '{ "foo": asd }'
    assert parse(e) == :error
  end
end
