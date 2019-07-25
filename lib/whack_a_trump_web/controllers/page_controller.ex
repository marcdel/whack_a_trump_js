defmodule WhackATrumpWeb.PageController do
  use WhackATrumpWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
