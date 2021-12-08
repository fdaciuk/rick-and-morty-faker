defmodule RMFaker do
  defdelegate get_char_by_id(id), to: RMFaker.Char.Get, as: :get_char_by_id
end
