# typed: strict

module Day6
  class Direction < T::Enum
    enums do
      Up = new
      Right = new
      Down = new
      Left = new
    end
  end
end
