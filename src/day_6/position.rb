# typed: strict

module Day6
  class Position
    extend T::Sig

    sig { returns(Integer) }
    attr_reader :x

    sig { returns(Integer) }
    attr_reader :y

    sig { params(x: Integer, y: Integer).void }
    def initialize(x, y)
      @x = x
      @y = y
    end

    sig { returns(String) }
    def to_s
      "(#{x}, #{y})"
    end

    sig { params(other: Position).returns(Position) }
    def add(other)
      Position.new(@x + other.x, @y + other.y)
    end

    sig { params(other: Position).returns(Position) }
    def +(other)
      add(other)
    end
  end
end
