defmodule RMFaker.Services.Filesystem.Char.Get do
  @not_found {:error, "Character not found"}

  def get_char_by_id(id) do
    per_page = 20

    String.to_integer("#{id}") / per_page
    |> ceil()
    |> get_file_from_disk_by_page(id)
  end

  defp get_file_from_disk_by_page(page, id) do
    case File.read("./data/page-#{page}.json") do
      {:ok, data} -> Jason.decode(data) |> get_char_from_file(id)
      {:error, _} -> @not_found
    end
  end

  defp get_char_from_file({:error, _} = error, _id), do: error

  defp get_char_from_file({:ok, %{"results" => results}}, id) do
    results
    |> Enum.find(@not_found, fn %{"id" => internalId} -> id == internalId end)
    |> handle_result()
  end

  defp handle_result({:error, _} = error), do: error
  defp handle_result(data), do: {:ok, data}
end
