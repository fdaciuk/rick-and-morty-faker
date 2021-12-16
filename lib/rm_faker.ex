defmodule RMFaker do
  defdelegate get_random_char(), to: RMFaker.Services.Char, as: :get_random_char
  defdelegate get_char_by_id(id), to: RMFaker.Services.Char, as: :get_char_by_id
  defdelegate get_chars_by_id(ids), to: RMFaker.Services.Char, as: :get_chars_by_id
  defdelegate get_chars_from_page(page), to: RMFaker.Services.Char, as: :get_chars_from_page
end
