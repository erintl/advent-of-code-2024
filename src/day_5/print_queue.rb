# typed: strict

require_relative("page_rules")
require_relative("page_update")

module Day5
  class PrintQueue
    extend T::Sig

    sig { params(filename: String).void }
    def initialize(filename)
      @page_rules = T.let(PageRules.new, PageRules)
      @page_updates = T.let([], T::Array[PageUpdate])
      read_file(filename)
    end

    sig { returns(Integer) }
    def check_updates
      valid_updates = @page_updates.filter do |update|
        update.valid?(@page_rules)
      end
      valid_updates.map(&:middle_page).sum
    end

    sig { returns(Integer) }
    def fix_updates
      invalid_updates = @page_updates.reject do |update|
        update.valid?(@page_rules)
      end

      invalid_updates.map { |update| update.fix2(@page_rules) }.map(&:middle_page).sum
    end

    sig { params(filename: String).void }
    def read_file(filename)
      lines = T.let([], T::Array[String])
      File.foreach(filename) do |line|
        lines << line.chomp
      end

      index = T.cast(lines.find_index(""), Integer)
      rules = T.cast(lines[0...index], T::Array[String])
      updates = T.cast(lines[index + 1..], T::Array[String])
      rules_array = T.let([], T::Array[T::Array[Integer]])
      rules.each do |rule|
        rules_array << rule.split("|").map(&:to_i)
      end
      @page_rules = PageRules.new(rules_array)

      updates.each do |update|
        @page_updates << PageUpdate.new(update.split(",").map(&:to_i))
      end
    end
  end
end
