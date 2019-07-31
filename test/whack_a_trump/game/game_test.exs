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
end
