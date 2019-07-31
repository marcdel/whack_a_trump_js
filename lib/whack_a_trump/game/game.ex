defmodule WhackATrump.Game do
  alias WhackATrump.{GameState, Hole}

  def new do
    %GameState{}
  end

  def start(game_state) do
    %{game_state | started: true}
  end

  def peep(%{started: false} = game_state), do: game_state

  def peep(game_state) do
    random_index = get_new_index(game_state)

    game_state
    |> update_current_hole()
    |> update_next_hole(random_index)
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
