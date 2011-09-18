class Column
  class NumberColumn < Column
    TYPE_REG_EXP = /\d+/

    class << self
      def convert(value)
        match = TYPE_REG_EXP.match(value)
        match ? type.to_i : nil
      end
    end
  end
end
