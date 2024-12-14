# typed: strict

module Day6
  class FileReader
    extend T::Sig

    sig { params(filename: String).void }
    def initialize(filename)
      @filename = filename
    end

    sig { returns(T::Array[T::Array[String]]) }
    def read_file
      map = T.let([], T::Array[T::Array[String]])
      File.foreach(@filename) do |line|
        map << line.chomp.chars
      end
      map
    end
  end
end
