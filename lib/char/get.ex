defmodule RMFaker.Char.Get do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://rickandmortyapi.com/api/character"
  plug Tesla.Middleware.JSON

  def get_char_by_id(id) do
    get("/#{id}")
    |> handle_request()
  end

  def handle_request({:ok, %Tesla.Env{status: 200, body: body}}) do
    {:ok, body}
  end

  def handle_request({:ok, %Tesla.Env{status: status, body: %{"error" => error}}}) when status == 404 or status == 500 do
    {:error, error}
  end

  def handle_request({:error, _error} = error) do
    error
  end
end
