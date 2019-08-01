defmodule EmojitransTest do
  use ExUnit.Case
  doctest Emojitrans

  test "greets the world" do
    assert Emojitrans.hello() == :world
  end
end
