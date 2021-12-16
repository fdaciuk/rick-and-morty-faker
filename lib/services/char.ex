defmodule RMFaker.Services.Char do
  alias RMFaker.Services.Filesystem, as: Service

  defdelegate get_char_by_id(id), to: Service.Char.Get, as: :get_char_by_id
  defdelegate get_chars_by_id(ids), to: Service.Char.Get, as: :get_chars_by_id
  defdelegate get_chars_from_page(page), to: Service.Char.Get, as: :get_chars_from_page

  def get_random_char() do
    Enum.random(1..826)
    |> get_char_by_id()
  end
end
