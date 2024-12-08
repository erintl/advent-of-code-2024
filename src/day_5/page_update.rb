# typed: strict

module Day5
  class PageUpdate
    extend T::Sig

    sig { returns(T::Array[Integer]) }
    attr_reader :pages

    sig { params(pages: T::Array[Integer]).void }
    def initialize(pages)
      @pages = pages
    end

    sig { returns(Integer) }
    def middle_page
      T.must(@pages[@pages.size / 2])
    end

    sig { params(page_rules: PageRules).returns(T::Boolean) }
    def valid?(page_rules)
      valid = T.let(true, T::Boolean)
      @pages.each_with_index do |page, i|
        previous_pages = T.must(@pages[0...i])
        after_pages = page_rules.page_rule(page)
        valid = false if previous_pages.intersect?(after_pages)
      end
      valid
    end

    sig { params(page_rules: PageRules).returns(PageUpdate) }
    def fix(page_rules)
      return self if valid?(page_rules)

      fixed_pages = @pages.clone.map(&:clone)
      window_first = 0
      window_last = 1

      while window_last < fixed_pages.size
        if page_rules.page_rule(fixed_pages[window_last]).include?(fixed_pages[window_first])
          fixed_pages[window_first], fixed_pages[window_last] = fixed_pages[window_last], fixed_pages[window_first]
        end
        window_last += 1
        next unless window_last == fixed_pages.size

        window_first += 1
        window_last = window_first + 1
      end
      PageUpdate.new(fixed_pages)
    end
  end
end
