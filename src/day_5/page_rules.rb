# typed: strict

module Day5
  class PageRules
    extend T::Sig

    sig { params(rules_array: T::Array[T::Array[Integer]]).void }
    def initialize(rules_array = [])
      @rules = T.let({}, T::Hash[Integer, T::Array[Integer]])
      rules_array.each do |rule|
        a, b = rule
        a = T.cast(a, Integer)
        b = T.cast(b, Integer)

        page = @rules[a]
        page ? T.must(@rules[a]) << b : @rules[a] = [b]
      end
    end

    sig { params(page: Integer).returns(T::Array[Integer]) }
    def page_rule(page)
      @rules.fetch(page, [])
    end
  end
end
