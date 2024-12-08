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
        valid = false unless (previous_pages - after_pages) == previous_pages
      end
      valid
    end
  end
end
