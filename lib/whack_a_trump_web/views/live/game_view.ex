defmodule WhackATrumpWeb.GameView do
  use Phoenix.LiveView
  alias WhackATrump.Game
  alias WhackATrumpWeb.LiveView

  def render(assigns) do
    LiveView.render("game.html", assigns)
  end

  def mount(_session, socket) do
    if connected?(socket), do: :timer.send_interval(1000, self(), :tick)

    {:ok, assign(socket, game_state: Game.new())}
  end

  def handle_event("start-game", _, socket) do
    {:noreply, update(socket, :game_state, fn game_state ->
      Game.start(game_state)
    end)}
  end

  def handle_event("bonk", index, socket) do
    {:noreply, update(socket, :game_state, fn game_state ->
      {bonked_hole_index, _} = Integer.parse(index)
      Game.bonk(game_state, bonked_hole_index)
    end)}
  end

  def handle_info(:tick, socket) do
    {:noreply, update(socket, :game_state, fn game_state ->
      Game.peep(game_state)
    end)}
  end
end
