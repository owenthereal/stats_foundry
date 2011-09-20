class Column
  class DateTimeColumn < Column
    TYPE_REG_EXP = /\A\d{4}-\d{2}-\d{2}(?:\s\d{2}:\d{2}:\d{2})?\z/

    class << self
      def convert(value)
        match = TYPE_REG_EXP.match(value)
        match ? Time.zone.parse(value) : nil
      end
    end
  end
end
