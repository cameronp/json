defmodule NumberTest do
  use ExUnit.Case
  import Parser.Number

  doctest Parser.Number


  test "integer" do
    int = '100fgdsfg'
    neg = '-299ffjd'
    bad = 'a134'
    leading = '01233'
    zero = '0'

    assert parse(zero) == {0, ''}
    assert parse(int) == {100, 'fgdsfg'}
    assert parse(neg) == {-299, 'ffjd'}
    assert parse(bad) == :error
    assert parse(leading) == {1233, ''}
  end

  test "capture" do
    int = '100fgdsfg'
    assert capture(int) == { 100, 'fgdsfg'}
  end


end
