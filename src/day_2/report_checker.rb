# typed: strict

require_relative("file_reader")
require_relative("level_direction")

module Day2
  class ReportChecker
    extend T::Sig

    MIN = 1
    MAX = 3

    sig { params(reports: T::Array[T::Array[Integer]]).void }
    def initialize(reports)
      @reports = reports
    end

    sig { returns(Integer) }
    def check_reports
      @reports.reduce(0) { |sum, report| sum + (check_report(report) == true ? 1 : 0) }
    end

    sig { params(report: T::Array[Integer]).returns(T::Boolean) }
    def check_report(report)
      range = (1...report.size)
      direction = level_direction(T.must(report[0]), T.must(report[1]))

      range.map do |i|
        check_diff(T.must(report[i]), T.must(report[i - 1])) &&
          check_direction(T.must(report[i]), T.must(report[i - 1]), direction)
      end.none?(false)
    end

    private

    sig { params(val1: Integer, val2: Integer).returns(T::Boolean) }
    def check_diff(val1, val2)
      diff = (val1 - val2).abs
      (diff >= MIN) && (diff <= MAX)
    end

    sig { params(val1: Integer, val2: Integer, direction: LevelDirection).returns(T::Boolean) }
    def check_direction(val1, val2, direction)
      case direction
      when LevelDirection::Increasing
        (val1 - val2).negative?
      when LevelDirection::Decreasing
        (val1 - val2).positive?
      else
        T.absurd(direction)
      end
    end

    sig { params(val1: Integer, val2: Integer).returns(LevelDirection) }
    def level_direction(val1, val2)
      (val1 - val2).positive? ? LevelDirection::Increasing : LevelDirection::Decreasing
    end
  end
end
