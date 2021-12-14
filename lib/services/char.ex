defmodule RMFaker.Services.Char do
  alias RMFaker.Services.Filesystem, as: Service

  defdelegate get_char_by_id(id), to: Service.Char.Get, as: :get_char_by_id

  def get_random_char() do
    Enum.random(1..826)
    |> get_char_by_id()
  end
end
