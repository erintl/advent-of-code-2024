# typed: strict

require_relative("position")
require_relative("direction")

GUARD = T.let("^".freeze, String)
OBSTACLE = T.let("#".freeze, String)

module Day6
  class GuardTracker
    extend T::Sig

    sig { params(guard_map: T::Array[T::Array[String]]).void }
    def initialize(guard_map)
      @guard_map = guard_map
      @x_size = T.let(T.must(@guard_map.first).size, Integer)
      @y_size = T.let(@guard_map.size, Integer)
      @guard_position = T.let(find_guard_position(@guard_map), Position)
      @guard_direction = T.let(Direction::Up, Direction)
      @active = T.let(true, T::Boolean)
    end

    sig { returns(Integer) }
    def run
      while move_guard; end
      @active = false
      T.must(@guard_map[@guard_position.x])[@guard_position.y] = "X"
      @guard_map.reduce(0) { |sum, row| sum + row.count("X") }
    end

    private

    sig { params(guard_map: T::Array[T::Array[String]]).returns(Position) }
    def find_guard_position(guard_map)
      x = 0
      y = 0
      guard_map.each_with_index do |row, i|
        if row.include?(GUARD)
          x = i
          y = T.must(row.index(GUARD))
        end
      end
      Position.new(x, y)
    end

    sig { void }
    def show_state
      puts "Guard: #{@guard_position}: #{@guard_direction.serialize}"
      @guard_map.each { |row| puts row.join }
    end

    sig { returns(T::Boolean) }
    def move_guard
      return false unless @active

      make_move(next_guard_position)
    end

    sig { returns(Position) }
    def next_guard_position
      case @guard_direction
      when Direction::Up
        @guard_position + Position.new(-1, 0)
      when Direction::Right
        @guard_position + Position.new(0, 1)
      when Direction::Down
        @guard_position + Position.new(1, 0)
      when Direction::Left
        @guard_position + Position.new(0, -1)
      else
        T.absurd(@guard_direction)
      end
    end

    sig { params(next_position: Position).returns(T::Boolean) }
    def make_move(next_position)
      return false unless valid_move?(next_position)

      if T.must(@guard_map[next_position.x])[next_position.y] == OBSTACLE
        turn_guard
      else
        T.must(@guard_map[next_position.x])[next_position.y] = "^"
        T.must(@guard_map[@guard_position.x])[@guard_position.y] = "X"
        @guard_position = next_position
      end
      true
    end

    sig { params(next_position: Position).returns(T::Boolean) }
    def valid_move?(next_position)
      next_position.x >= 0 &&
        next_position.y >= 0 &&
        next_position.x < @x_size &&
        next_position.y < @y_size
    end

    sig { void }
    def turn_guard
      @guard_direction =
        case @guard_direction
        when Direction::Up
          Direction::Right
        when Direction::Right
          Direction::Down
        when Direction::Down
          Direction::Left
        when Direction::Left
          Direction::Up
        end
    end
  end
end
