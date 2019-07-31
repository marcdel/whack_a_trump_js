defmodule WhackATrumpWeb.GameView do
  use Phoenix.LiveView
  alias WhackATrumpWeb.LiveView

  def render(assigns) do
    LiveView.render("game.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, assign(socket, test: "Ready!")}
  end
end
