defmodule Fotd do

  def random() do
    Fotd.Cache.random()
  end
end
