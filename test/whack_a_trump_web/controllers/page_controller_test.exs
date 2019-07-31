defmodule WhackATrumpWeb.PageControllerTest do
  use WhackATrumpWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Whack-a-Trump!"
  end
end
