# typed: strict

module Day4
  class FileReader
    extend T::Sig

    sig { returns(T::Array[String]) }
    attr_reader :word_grid

    sig { params(filename: String).void }
    def initialize(filename)
      @filename = filename
      @word_grid = T.let([], T::Array[String])
    end

    sig { returns(T::Array[String]) }
    def read_file
      File.foreach(@filename) do |line|
        @word_grid << line.chomp
      end
      @word_grid
    end
  end
end
