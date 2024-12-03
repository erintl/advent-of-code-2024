# typed: strict

require "sorbet-runtime"
require_relative("file_reader")
require_relative("report_checker")

module Day2
  class Runner
    class << self
      extend T::Sig

      sig { void }
      def main
        file_reader = FileReader.new("input/input.txt")
        reports = file_reader.read_file
        report_checker = ReportChecker.new(reports)
        puts "Number of safe reports: #{report_checker.check_reports}"
      end
    end
  end
end

Day2::Runner.main
