# typed: strict

require "sorbet-runtime"
require_relative("distance_calculator")

module Day1
  class Runner
    class << self
      extend T::Sig

      sig { void }
      def main
        distance_calculator = DistanceCalculator.new("input/input.txt")
        puts "Total distance: #{distance_calculator.calculate_distance}"
        puts "Simularity score: #{distance_calculator.calculate_simulatarity_score}"
      end
    end
  end
end

Day1::Runner.main
