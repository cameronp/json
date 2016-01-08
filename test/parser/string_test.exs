defmodule StringTest do
  use ExUnit.Case
  import Parser.String

  test "simple" do
    simple = ~s("simple string")
    assert parse(simple) == {"simple string", ''}
  end

  test "return remaining" do
    extra =  ~s("simple string"extracrap)
    assert parse(extra) == {"simple string", 'extracrap'}
  end

  test "bad form" do
    bad = ~s(sdf"too late"a)
    assert parse(bad) == :error
  end

  test "capture" do
    extra =  ~s("simple string"extracrap)
    assert capture(extra) == {"simple string", 'extracrap'}
  end

  test "escaped quote" do
    esc_quote = ~s("Foo \\"bar\\""extra)
    assert parse(esc_quote) == {~s(Foo "bar"), 'extra'}
  end
end
