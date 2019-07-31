defmodule WhackATrumpWeb.PageController do
  use WhackATrumpWeb, :controller
  alias Phoenix.LiveView

  def index(conn, _params) do
    LiveView.Controller.live_render(conn, WhackATrumpWeb.GameView, session: %{})
  end
end
