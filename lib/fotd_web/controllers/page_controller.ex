defmodule FotdWeb.PageController do
  use FotdWeb, :controller

  def index(conn, _params) do
    today = Date.to_erl(Date.utc_today)
    fotd = Fotd.random(today)
    render conn, "index.html", fotd: fotd
  end
end
