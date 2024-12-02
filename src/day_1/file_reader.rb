# typed: strict

module Day1
  class FileReader
    extend T::Sig

    sig { returns(T::Array[Integer]) }
    attr_reader :list1

    sig { returns(T::Array[Integer]) }
    attr_reader :list2

    sig { params(filename: String).void }
    def initialize(filename)
      @filename = filename
      @list1 = T.let([], T::Array[Integer])
      @list2 = T.let([], T::Array[Integer])
    end

    sig { void }
    def read_file
      File.foreach(@filename) do |line|
        item1, item2 = line.split.map(&:strip)
        @list1 << item1.to_i
        @list2 << item2.to_i
      end
    end
  end
end
