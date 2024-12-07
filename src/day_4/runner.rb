# typed: strict

require "sorbet-runtime"
require_relative("file_reader")
require_relative("xmas_finder")

module Day4
  class Runner
    class << self
      extend T::Sig

      sig { void }
      def main
        file_reader = FileReader.new("input/input.txt")
        word_grid = file_reader.read_file
        xmas_finder = XmasFinder.new(word_grid)

        xmas_count = xmas_finder.xmas_count
        puts "Xmas count: #{xmas_count}"

        x_mas_count = xmas_finder.x_mas_count
        puts "X-mas count: #{x_mas_count}"
      end
    end
  end
end

Day4::Runner.main
