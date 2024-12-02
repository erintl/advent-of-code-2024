# typed: strict

require_relative("file_reader")

module Day1
  class DistanceCalculator
    extend T::Sig

    sig { params(filename: String).void }
    def initialize(filename)
      @filename = filename
      @file_reader = T.let(FileReader.new(filename), FileReader)

      @file_reader.read_file
      @list1 = T.let(@file_reader.list1, T::Array[Integer])
      @list2 = T.let(@file_reader.list2, T::Array[Integer])
    end

    sig { returns(Integer) }
    def calculate_distance
      list1 = @list1.sort
      list2 = @list2.sort
      range = (0...list1.size)

      range.reduce(0) { |sum, i| sum + (T.must(list1[i]) - T.must(list2[i])).abs }
    end

    sig { returns(Integer) }
    def calculate_simulatarity_score
      @list1.reduce(0) { |sum, i| sum + (i * @list2.count(i)) }
    end
  end
end
