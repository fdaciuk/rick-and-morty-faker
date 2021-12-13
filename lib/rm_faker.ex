defmodule RMFaker do
  defdelegate get_random_char(), to: RMFaker.Char.Get, as: :get_random_char
  defdelegate get_char_by_id(id), to: RMFaker.Char.Get, as: :get_char_by_id
end
