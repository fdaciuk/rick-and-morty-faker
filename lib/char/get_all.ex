defmodule RMFaker.Char.GetAll do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://rickandmortyapi.com/api/character"
  plug Tesla.Middleware.JSON

  def get_all_chars() do
    get_chars_by_page({:page, 1})
  end

  defp get_chars_by_page({:error, _error} = error), do: error

  defp get_chars_by_page({:page, page}) do
    result = get("/?page=#{page}")
    |> handle_get_all_chars(page)

    case result do
      {:page, page} ->
        Process.sleep(1000)
        get_chars_by_page({:page, page + 1})
      error -> get_chars_by_page(error)
    end
  end

  defp handle_get_all_chars(result, page) do
    case result do
      {:ok, %Tesla.Env{status: 200, body: body}} -> save_on_disk(body, page)
      {:ok, %Tesla.Env{status: 404}} -> {:error, "Acabou"}
      _ -> result
    end
  end

  defp save_on_disk(body, page) do
    IO.puts("Salvando dados da página #{page}...")

    {:ok, content} = Jason.encode(body)
    File.write("./data/page-#{page}.json", content)

    {:page, page}
  end
end
