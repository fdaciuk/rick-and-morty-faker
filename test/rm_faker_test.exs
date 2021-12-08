defmodule RmFakerTest do
  use ExUnit.Case
  doctest RmFaker

  test "greets the world" do
    assert RmFaker.hello() == :world
  end
end
