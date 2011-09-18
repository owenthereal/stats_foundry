class Column
  class DateTimeColumn < Column
    class << self
      def convert(value)
        Time.zone.parse(value)
      end
    end
  end
end
