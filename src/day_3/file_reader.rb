# typed: strict

module Day3
  class FileReader
    extend T::Sig

    sig { returns(String) }
    attr_reader :instructions

    sig { params(filename: String).void }
    def initialize(filename)
      @filename = filename
      @instructions = T.let("", String)
    end

    sig { returns(String) }
    def read_file
      instruction_input = T.let([], T::Array[String])
      File.foreach(@filename) do |line|
        instruction_input << line
      end
      @instructions = instruction_input.join
    end
  end
end
