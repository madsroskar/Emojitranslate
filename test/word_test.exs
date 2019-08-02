defmodule WordTest do
  use ExUnit.Case
  doctest Word

  defmodule Case do
    defstruct [:input, :expected]
  end

  describe "passing in a single word for transformation" do
    test "singularizes words" do
      cases = [
        %Case{input: "shy guys", expected: "shy guy"},
        %Case{input: "nipper spores", expected: "nipper spore"},
        %Case{input: "flying shy guy", expected: nil}
      ]

      Enum.each(cases, fn c -> assert Word.to_singular(c.input) == c.expected end)
    end

    test "pluzalizes words" do
      cases = [
        %Case{input: "bee", expected: "bees"},
        %Case{input: "blargg", expected: "blarggs"},
        %Case{input: "bob-ombs", expected: nil}
      ]

      Enum.each(cases, fn c -> assert Word.to_plural(c.input) == c.expected end)
    end

    test "converts from present tense" do
      cases = [
        %Case{input: "sitting", expected: ["sitt", "sitte", "sit"]},
        %Case{input: "smashing", expected: ["smash", "smashe", "smas"]},
        %Case{input: "whacking", expected: ["whack", "whacke", "whac"]},
        %Case{input: "jump", expected: nil}
      ]

      Enum.each(cases, fn c -> assert Word.from_present_tense(c.input) == c.expected end)
    end
  end
end
