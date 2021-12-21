defmodule RMFaker.Services.Filesystem.Char.Filter do
  # @filter_options [:name, :status, :species, :type, :gender]
  # @status_options ["alive", "dead", "unknown"]
  # @gender_options ["female", "male", "genderless", "unknown"]

  def get_chars_by(filter, callback) do
    data = callback.()

    list = Keyword.new(filter)
    |> Enum.map(fn {key, value} ->
      Atom.to_string(key) |> get_chars_by_property(value, data)
    end)

    list
    |> List.flatten()
    |> Enum.reduce(%{}, fn %{"id" => id} = character, acc ->
      {char_quantity, _char} = Map.get(acc, id, {0, %{}})
      Map.put(acc, id, {char_quantity + 1, character})
    end)
    |> Enum.filter(fn {_id, {quantity, _character}} ->
      quantity == length(list)
    end)
    |> Enum.map(fn ({_id, {_quantity, character}}) -> character end)

    # TODO
    # Tratamento de erros
    # Verificar se as props e valores dos filtros estão corretas
  end

  defp get_chars_by_property(keyName, filterValue, {:ok, %{"results" => results}}) do
    results
    |> Enum.filter(fn result ->
      String.contains?(
        String.downcase(result[keyName]),
        String.downcase(filterValue)
      )
    end)
    # TODO: Deletar
    |> Enum.map(fn char -> %{"id" => char["id"], "name" => char["name"]} end)
  end
end
