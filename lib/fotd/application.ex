defmodule Fotd.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Fotd.Cache, []),
      supervisor(Fotd.Repo, []),
      supervisor(FotdWeb.Endpoint, [])
    ]

    opts = [strategy: :one_for_one, name: Fotd.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    FotdWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
