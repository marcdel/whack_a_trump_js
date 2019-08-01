defmodule WhackATrump.GameTest do
  use ExUnit.Case, async: true
  alias WhackATrump.Game

  describe "peep/1" do
    test "does nothing if game is not started" do
      game_state =
        Game.new()
        |> Game.peep()

      assert Enum.all?(game_state.holes, fn hole -> hole.up == false end)
    end

    test "marks up true for a random hole" do
      game_state =
        Game.new()
        |> Game.start()
        |> Game.peep()

      assert game_state.current_hole_index != nil
      assert Enum.at(game_state.holes, game_state.current_hole_index).up == true
    end
  end

  describe "bonk" do
    test "does nothing on a miss" do
      game_state =
        Game.new()
        |> Game.start()
        |> Map.put(:current_hole_index, 1)

      assert Game.bonk(game_state, 2) == game_state
    end

    test "increases current score on a hit" do
      game_state =
        Game.new()
        |> Game.start()
        |> Game.peep()

      game_state = Game.bonk(game_state, game_state.current_hole_index)

      assert game_state.current_score == 1
    end

    test "increases high score when current score is greater than high score" do
      game_state =
        Game.new()
        |> Game.start()
        |> Game.peep()
        |> Map.put(:high_score, 1)

      game_state = Game.bonk(game_state, game_state.current_hole_index)
      assert game_state.current_score == 1
      assert game_state.high_score == 1

      game_state = Game.bonk(game_state, game_state.current_hole_index)
      assert game_state.current_score == 2
      assert game_state.high_score == 2
    end
  end
end
