# typed: strict

require "sorbet-runtime"
require_relative("file_reader")
require_relative("guard_tracker")

module Day6
  class Runner
    class << self
      extend T::Sig

      sig { void }
      def main
        file_reader = FileReader.new("input/input.txt")
        guard_map = file_reader.read_file
        guard_tracker = GuardTracker.new(guard_map)

        positions_visited = guard_tracker.run
        puts "Positions visited: #{positions_visited}"
      end
    end
  end
end

Day6::Runner.main
