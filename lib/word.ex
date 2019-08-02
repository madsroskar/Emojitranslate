defmodule Word do
  @moduledoc """
  The Word module is a utility module for generating different forms
  of a word in the most simle way possible.
  """

  @doc """
  Transforms a word to it's singular form, if it's a pluralized word
  ending in 's'.

  Returns the singularized word if successful, nil if unsuccessful.

  ## Examples

        iex> Word.to_singular("watermelons")
        "watermelon"

        iex> Word.to_singular("watermelon")
        nil
  """
  def to_singular(word) do
    if String.ends_with?(word, "s") && String.length(word) > 2 do
      String.slice(word, 0, String.length(word) - 1)
    end
  end

  @doc """
  Transforms a word to it's plural form, unless it ends in 's'.

  Returns the pluralized word if successful, nil if unsuccessful.

  ## Examples

        iex> Word.to_plural("banana")
        "bananas"

        iex> Word.to_plural("bananas")
        nil
  """
  def to_plural(word) do
    unless String.ends_with?(word, "s") do
      "#{word}s"
    end
  end

  @doc """
  Transforms a verb in the present continuous tense into other forms.

  The goal is to have the following transformations available:
  * riding -> ride
  * sitting -> sit
  * whacking -> whack

  ## Examples

        iex> Word.from_present_tense("riding")
        ["rid", "ride", "ri"]

        iex> Word.from_present_tense("sitting")
        ["sitt", "sitte", "sit"]

        iex> Word.from_present_tense("whacking")
        ["whack", "whacke", "whac"]

        iex> Word.from_present_tense("move")
        nil
  """
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
