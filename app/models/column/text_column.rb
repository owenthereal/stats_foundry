class Column
  class TextColumn < Column
    TYPE_REG_EXP = /\A(?:'(.+)'|\"(.+)\")\z/

    class << self
      def convert(value)
        match = TYPE_REG_EXP.match(value)
        match ? (match[1] || match[2]) : nil
      end
    end
  end
end
