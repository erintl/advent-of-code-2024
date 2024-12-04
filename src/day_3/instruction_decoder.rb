# typed: strict

module Day3
  class InstructionDecoder
    extend T::Sig

    sig { params(instructions_raw: String).void }
    def initialize(instructions_raw)
      @instructions_raw = instructions_raw
    end

    sig { returns(Integer) }
    def instructions_sum
      instructions = decode_instructions(@instructions_raw)
      instructions.reduce(0) { |sum, i| sum + (T.must(i[0]) * T.must(i[1])) }
    end

    sig { returns(Integer) }
    def instructions_sum2
      instructions_raw = parse_instructions2(@instructions_raw)
      instructions = decode_instructions(instructions_raw)
      instructions.reduce(0) { |sum, i| sum + (T.must(i[0]) * T.must(i[1])) }
    end

    private

    sig { params(instructions_raw: String).returns(T::Array[T::Array[Integer]]) }
    def decode_instructions(instructions_raw)
      instructions = T.cast(instructions_raw.scan(/mul\((\d{1,3}),(\d{1,3})\)/), T::Array[T::Array[String]])
      instructions.map { |i| i.map(&:to_i) }
    end

    sig { params(input_raw: String).returns(String) }
    def parse_instructions2(input_raw)
      matches = T.let([], T::Array[String])
      matches << T.must(input_raw.slice!(/.+?(?=do\(\)|don't\(\))/m))
      matching = T.let(true, T::Boolean)
      while matching
        match = input_raw.slice!(/(do\(\)|don't\(\)).+?(?=do\(\)|don't\(\))/m)
        if match.nil?
          matches << input_raw if input_raw.start_with?("do()")
          matching = false
        elsif match.start_with?("do()")
          matches << match
        end
      end
      matches.join
    end
  end
end
