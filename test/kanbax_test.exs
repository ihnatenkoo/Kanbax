defmodule KanbaxTest do
  use ExUnit.Case
  doctest Kanbax

  test "greets the world" do
    assert Kanbax.hello() == :world
  end
end
