defmodule RMFaker.Services.Api.Char.Get do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://rickandmortyapi.com/api/character"
  plug Tesla.Middleware.JSON

  def get_chars_by_id(ids) do
    case Jason.encode(ids) do
      {:ok, data} -> pick_ids(data)
      {:error, _} = error -> error
    end
  end

  defp pick_ids(str) do
    str
    |> String.replace(["[", "]"], "")
    |> get_char_by_id()
  end

  def get_char_by_id(id) do
    get("/#{id}")
    |> handle_request()
  end

  defp handle_request(result) do
    case result do
      {:ok, %Tesla.Env{status: 200, body: body}} -> {:ok, body}
      {:ok, %Tesla.Env{status: status, body: %{"error" => error}}}
        when status == 404 or status == 500 -> {:error, error}
      {:error, _error} = error -> error
    end
  end
end
