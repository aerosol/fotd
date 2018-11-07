defmodule FotdWeb.PageController do
  use FotdWeb, :controller

  def index(conn, _params) do
    today = Date.to_erl(Date.utc_today)
    :rand.seed(:exs1024s, today)
    render conn, "index.html", fotd: Fotd.random()
  end

  def index_diceroll(conn, _params) do
    :rand.seed(:exs1024s)
    render conn, "index.html", fotd: Fotd.random()
  end
end
