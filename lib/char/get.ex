defmodule RMFaker.Char.Get do
  def get_random_char() do
    RMFaker.Services.Char.get_random_char()
  end

  def get_char_by_id(id) do
    RMFaker.Services.Char.get_char_by_id(id)
  end
end
