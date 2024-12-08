# typed: strict

require "sorbet-runtime"
require_relative("print_queue")

module Day5
  class Runner
    class << self
      extend T::Sig

      sig { void }
      def main
        print_queue = PrintQueue.new("input/input.txt")
        valid_value = print_queue.check_updates
        fixed_value = print_queue.fix_updates

        puts "value: #{valid_value}"
        puts "fixed value: #{fixed_value}"
      end
    end
  end
end

Day5::Runner.main
