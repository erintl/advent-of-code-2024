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
        page_value = print_queue.check_updates

        puts "Page value: #{page_value}"
      end
    end
  end
end

Day5::Runner.main
