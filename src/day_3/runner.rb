# typed: strict

require "sorbet-runtime"
require_relative("file_reader")
require_relative("instruction_decoder")

module Day3
  class Runner
    class << self
      extend T::Sig

      sig { void }
      def main
        file_reader = FileReader.new("input/input.txt")
        instructions = file_reader.read_file
        instruction_decoder = InstructionDecoder.new(instructions)

        sum1 = instruction_decoder.instructions_sum
        puts "Part 1 - the sum is: #{sum1}"

        sum2 = instruction_decoder.instructions_sum2
        puts "Part 2 - the sum is: #{sum2}"
      end
    end
  end
end

Day3::Runner.main
