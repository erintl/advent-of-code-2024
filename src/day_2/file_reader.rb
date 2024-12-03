# typed: strict

module Day2
  class FileReader
    extend T::Sig

    sig { returns(T::Array[T::Array[Integer]]) }
    attr_reader :reports

    sig { params(filename: String).void }
    def initialize(filename)
      @filename = filename
      @reports = T.let([], T::Array[T::Array[Integer]])
    end

    sig { returns(T::Array[T::Array[Integer]]) }
    def read_file
      @reports = []
      File.foreach(@filename) do |line|
        @reports << line.split.map(&:strip).map(&:to_i)
      end
      reports
    end
  end
end
