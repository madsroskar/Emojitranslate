json_content = nil

defmodule Emojitrans do
  @moduledoc """
  Documentation for Emojitrans.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Emojitrans.hello()
      :world

  """

  @json_path "#{System.cwd()}/emoji.json"

  defmodule TranslationError do
    defexception [:message]

    def get_message(reason) do
      "Can't translate the phrase. Reason: #{reason}"
    end

    @impl true
    def exception(value) do
      %TranslationError{message: get_message(value)}
    end
  end

  def translate(phrase) do
    result = get_json(@json_path)

    case result do
      {:ok, json} ->
        translate_phrase(phrase, json)

      {:error, reason} ->
        handle_error(reason)
    end
  end

  defp translate_phrase(phrase, json) do
    json_content = json
    words = phrase |> String.downcase() |> String.replace(~r/[\p{P}\p{S}]/, "") |> String.split()

    Enum.map(words, fn x -> translate_word(x, json) end) |> Enum.join("")
  end

  defp translate_word(word, json) do
    possibilities = get_word_variations(word)

    result =
      Enum.filter(json, fn emoji ->
        Enum.any?(elem(emoji, 1)["keywords"] ++ [elem(emoji, 0)], fn keyword ->
          Enum.member?(possibilities, keyword)
        end)
      end)

    a = Enum.map(result, fn element -> elem(element, 1)["char"] end) |> Enum.random()
  end

  defp get_word_variations(word) do
    List.flatten([
      word,
      "#{word}_face",
      Word.to_plural(word),
      Word.to_singular(word),
      Word.from_present_tense(word)
    ])
  end

  defp handle_error(reason) do
    raise TranslationError, reason
  end

  defp get_json(filename) do
    with {:ok, file_content} <- File.read(filename) do
      Poison.decode(file_content)
    end
  end
end
