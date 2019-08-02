defmodule Word do
  def to_singular(word) do
    if String.ends_with?(word, "s") && String.length(word) > 2 do
      String.slice(word, 0, String.length(word) - 1)
    end
  end

  def to_plural(word) do
    unless String.ends_with?(word, "s") do
      "#{word}s"
    end
  end

  def from_present_tense(word) do
    if String.ends_with?(word, "ing") do
      word = String.slice(word, 0, String.length(word) - 3)

      [
        word,
        "#{word}e",
        String.slice(word, 0, String.length(word) - 1)
      ]
    end
  end
end
