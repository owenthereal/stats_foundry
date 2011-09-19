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
        raw_data = hash_from_pairs(keys, values)

        Statement::InsertRow.new(table_id, raw_data)
      end

      private

      def split_entries(string)
        string.split(',').collect { |k| k.strip }
      end

      def hash_from_pairs(keys, values)
        hash = {}
        keys.size.times { |i| hash[keys[i]] = values[i] }
        hash
      end
    end
  end
end
