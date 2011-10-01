module StatementParser
  class InsertRow
    REG_EXP = /\AINSERT INTO (\d+) \((.+)\) VALUES \((.+)\);\z/i

    class << self
      def parse(statement)
        match = REG_EXP.match(statement)
        return nil unless match

        keys = split_entries(match[2])
        values = split_entries(match[3])
        return nil unless keys.length == values.length

        table_id = match[1].to_i
        values = Column.convert_data_types(values)
        row_data = hash_from_pairs(keys, values)

        Statement::InsertRow.new(:table_id => table_id, :row_data => row_data)
      end

      private

      def split_entries(string)
        string.split(',').collect(&:strip)
      end

      def hash_from_pairs(keys, values)
        hash = {}
        keys.size.times { |i| hash[keys[i]] = values[i] }
        hash
      end
    end
  end
end
