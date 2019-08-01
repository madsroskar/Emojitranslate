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

    @impl true
    def exception(value) do
      %TranslationError{message: "Can't translate the phrase. Reason: #{value}"}
    end
  end

  def hello do
    :world
  end

  def translate(phrase) do
    result = get_json(@json_path)

    case result do
      {:ok, json} ->
        translate_phrase(json)

      {:error, reason} ->
        handle_error(reason)
    end
  end

  def translate_phrase(json) do
    json
  end

  def handle_error(reason) do
    raise TranslationError, reason
  end

  def get_json(filename) do
    with {:ok, file_content} <- File.read(filename) do
      Poison.decode(file_content)
    end
  end
end

defmodule Emoji do
  @derive [Poison.Encoder]
  defstruct [:keywords, :char, :fitzpatric_scale, :category]
end
