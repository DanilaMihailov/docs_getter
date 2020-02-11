defmodule DocsGetterTest do
  use ExUnit.Case
  doctest DocsGetter

  test "greets the world" do
    assert DocsGetter.hello() == :world
  end
end
