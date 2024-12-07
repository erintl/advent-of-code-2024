# typed: strict

module Day4
  class XmasFinder
    extend T::Sig

    MATCH = T.let("XMAS".freeze, String)
    MAS_MATCH = T.let("MAS".freeze, String)
    SAM_MATCH = T.let("SAM".freeze, String)

    sig { params(word_grid: T::Array[String]).void }
    def initialize(word_grid)
      @word_grid = word_grid
      @width = T.let(word_grid.first&.size || 0, Integer)
      @height = T.let(word_grid.size, Integer)
    end

    sig { void }
    def show_grid
      puts @word_grid
    end

    sig { returns(Integer) }
    def xmas_count
      count = 0
      (0...@height).each do |i|
        (0...@width).each do |j|
          count += xmas_match(i, j)
        end
      end
      count
    end

    sig { returns(Integer) }
    def x_mas_count
      count = 0
      (0...@height).each do |i|
        (0...@width).each do |j|
          count += x_mas_match(i, j)
        end
      end
      count
    end

    private

    sig { params(pos_i: Integer, pos_j: Integer).returns(Integer) }
    def xmas_match(pos_i, pos_j)
      count = 0

      # right
      if pos_j < @width - 3
        a = T.must(@word_grid[pos_i])[pos_j]
        b = T.must(@word_grid[pos_i])[pos_j + 1]
        c = T.must(@word_grid[pos_i])[pos_j + 2]
        d = T.must(@word_grid[pos_i])[pos_j + 3]
        count += check_xmas_match([a, b, c, d].join)
      end

      # right-down
      if pos_j < @width - 3 && pos_i < @height - 3
        a = T.must(@word_grid[pos_i])[pos_j]
        b = T.must(@word_grid[pos_i + 1])[pos_j + 1]
        c = T.must(@word_grid[pos_i + 2])[pos_j + 2]
        d = T.must(@word_grid[pos_i + 3])[pos_j + 3]
        count += check_xmas_match([a, b, c, d].join)
      end

      # down
      if pos_i < @height - 3
        a = T.must(@word_grid[pos_i])[pos_j]
        b = T.must(@word_grid[pos_i + 1])[pos_j]
        c = T.must(@word_grid[pos_i + 2])[pos_j]
        d = T.must(@word_grid[pos_i + 3])[pos_j]
        count += check_xmas_match([a, b, c, d].join)
      end

      # left-down
      if pos_j > 2 && pos_i < @height - 3
        a = T.must(@word_grid[pos_i])[pos_j]
        b = T.must(@word_grid[pos_i + 1])[pos_j - 1]
        c = T.must(@word_grid[pos_i + 2])[pos_j - 2]
        d = T.must(@word_grid[pos_i + 3])[pos_j - 3]
        count += check_xmas_match([a, b, c, d].join)
      end

      # left
      if pos_j > 2
        a = T.must(@word_grid[pos_i])[pos_j]
        b = T.must(@word_grid[pos_i])[pos_j - 1]
        c = T.must(@word_grid[pos_i])[pos_j - 2]
        d = T.must(@word_grid[pos_i])[pos_j - 3]
        count += check_xmas_match([a, b, c, d].join)
      end

      # left up
      if pos_j > 2 && pos_i > 2
        a = T.must(@word_grid[pos_i])[pos_j]
        b = T.must(@word_grid[pos_i - 1])[pos_j - 1]
        c = T.must(@word_grid[pos_i - 2])[pos_j - 2]
        d = T.must(@word_grid[pos_i - 3])[pos_j - 3]
        count += check_xmas_match([a, b, c, d].join)
      end

      # up
      if pos_i > 2
        a = T.must(@word_grid[pos_i])[pos_j]
        b = T.must(@word_grid[pos_i - 1])[pos_j]
        c = T.must(@word_grid[pos_i - 2])[pos_j]
        d = T.must(@word_grid[pos_i - 3])[pos_j]
        count += check_xmas_match([a, b, c, d].join)
      end

      # right-up
      if pos_j < @width + 3 && pos_i > 2
        a = T.must(@word_grid[pos_i])[pos_j]
        b = T.must(@word_grid[pos_i - 1])[pos_j + 1]
        c = T.must(@word_grid[pos_i - 2])[pos_j + 2]
        d = T.must(@word_grid[pos_i - 3])[pos_j + 3]
        count += check_xmas_match([a, b, c, d].join)
      end

      count
    end

    sig { params(pos_i: Integer, pos_j: Integer).returns(Integer) }
    def x_mas_match(pos_i, pos_j)
      count = 0
      if pos_j < @width - 2 && pos_i < @height - 2
        a = T.must(@word_grid[pos_i])[pos_j]
        b = T.must(@word_grid[pos_i + 1])[pos_j + 1]
        c = T.must(@word_grid[pos_i + 2])[pos_j + 2]
        d = T.must(@word_grid[pos_i])[pos_j + 2]
        e = T.must(@word_grid[pos_i + 1])[pos_j + 1]
        f = T.must(@word_grid[pos_i + 2])[pos_j]
        count += check_x_mas_match([a, b, c].join, [d, e, f].join)
      end
      count
    end

    sig { params(input: String).returns(Integer) }
    def check_xmas_match(input)
      input.eql?(MATCH) ? 1 : 0
    end

    sig { params(input1: String, input2: String).returns(Integer) }
    def check_x_mas_match(input1, input2)
      match = (input1.eql?(MAS_MATCH) || input1.eql?(SAM_MATCH)) && (input2.eql?(MAS_MATCH) || input2.eql?(SAM_MATCH))
      match ? 1 : 0
    end
  end
end
