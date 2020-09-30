defmodule AshTestTest do
  use ExUnit.Case
  doctest AshTest

  test "greets the world" do
    assert AshTest.hello() == :world
  end
end
