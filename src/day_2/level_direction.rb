# typed: strict

module Day2
  class LevelDirection < T::Enum
    enums do
      Increasing = new
      Decreasing = new
    end
  end
end
