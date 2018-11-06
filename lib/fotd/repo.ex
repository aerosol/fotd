defmodule Fotd.Repo do
  use Ecto.Repo, otp_app: :fotd

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, _), do: :ignore
end
