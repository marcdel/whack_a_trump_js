defmodule WhackATrump.Game do
  alias WhackATrump.{Game, GameState, Hole}

  def new do
    %GameState{}
  end

  def start(game_state) do
    %{game_state | started: true}
  end

  def stop(game_state) do
    %{Game.new() | high_score: game_state.high_score}
  end

  def peep(%{started: false} = game_state), do: game_state

  def peep(game_state) do
    random_index = get_new_index(game_state)

    game_state
    |> update_current_hole()
    |> update_next_hole(random_index)
  end

  def bonk(%{current_hole_index: index} = game_state, bonked_index) when index != bonked_index do
    game_state
  end

  def bonk(game_state, _bonked_index) do
    new_score = game_state.current_score + 1

    new_high_score = if new_score > game_state.high_score do
      new_score
    else
      game_state.high_score
    end

    %{game_state | current_score: new_score, high_score: new_high_score}
  end

  defp get_new_index(game_state) do
    max_index = Enum.count(game_state.holes) - 1
    random_index = Enum.random(0..max_index)

    if(random_index == game_state.current_hole_index) do
      get_new_index(game_state)
    else
      random_index
    end
  end

  defp update_current_hole(%{current_hole_index: nil} = game_state), do: game_state

  defp update_current_hole(game_state) do
    updated_holes = List.replace_at(game_state.holes, game_state.current_hole_index, %Hole{up: false})
    %{game_state | holes: updated_holes}
  end

  defp update_next_hole(game_state, next_index) do
    updated_holes = List.replace_at(game_state.holes, next_index, %Hole{up: true})
    %{game_state | current_hole_index: next_index, holes: updated_holes}
  end
end
