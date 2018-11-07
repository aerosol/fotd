defmodule FotdWeb.PageControllerTest do
  use FotdWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Elixir Function of the Day"
  end

  test "GET /diceroll", %{conn: conn} do
    conn = get conn, "/diceroll"
    assert html_response(conn, 200) =~ "Elixir Function of the Day"
  end
end
