class Column
  class NumberColumn < Column
    TYPE_REG_EXP = /\A[+-]?\d+?(?:\.\d+|\.)?\z/

    class << self
      def convert(value)
        match = TYPE_REG_EXP.match(value)
        match ? value.to_f : nil
      end
    end
  end
end
