defmodule WhackATrump.GameState do
  alias WhackATrump.Hole

  defstruct [
    started: false,
    current_score: 0,
    high_score: 0,
    current_hole_index: nil,
    holes: [
      %Hole{},
      %Hole{},
      %Hole{},
      %Hole{},
      %Hole{},
      %Hole{},
    ]
  ]
end
