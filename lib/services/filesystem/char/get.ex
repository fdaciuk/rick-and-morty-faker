defmodule RMFaker.Services.Filesystem.Char.Get do
  @not_found {:error, "Character not found"}
  @page_not_found {:error, "There is nothing here"}

  def get_chars_by_id(ids) do
    result = ids
    |> Enum.map(&get_char_by_id/1)
    |> Enum.filter(&remove_errors/1)
    |> Enum.map(fn {:ok, data} -> data end)

    {:ok, result}
  end

  def get_char_by_id(id) do
    per_page = 20

    String.to_integer("#{id}") / per_page
    |> ceil()
    |> get_char_from_disk_by_page(id)
  end

  def get_chars_from_page(page) do
    page = if is_integer(page), do: page, else: 1
    get_file_from_disk_by_page(page)
  end

  defp remove_errors(result) do
    case result do
      {:ok, _} -> true
      {:error, _} -> false
    end
  end

  defp get_file_from_disk_by_page(page) do
    case File.read("./data/page-#{page}.json") do
      {:ok, data} -> Jason.decode(data)
      {:error, _} -> @page_not_found
    end
  end

  defp get_char_from_disk_by_page(page, id) do
    case get_file_from_disk_by_page(page) do
      {:ok, _} = result -> get_char_from_file(result, id)
      {:error, _} = error -> error
    end
  end

  defp get_char_from_file({:ok, %{"results" => results}}, id) do
    results
    |> Enum.find(@not_found, fn %{"id" => internalId} -> id == internalId end)
    |> handle_result()
  end

  defp handle_result({:error, _} = error), do: error
  defp handle_result(data), do: {:ok, data}
end
