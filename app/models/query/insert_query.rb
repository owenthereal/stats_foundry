class Query
  class InsertQuery < Query
    REG_EXP = /\AINSERT INTO (\d+) \((.+)\) VALUES \((.+)\);\z/i

    def self.parse?(query)
      REG_EXP =~ query
    end

    def validate
      parse(statement)

      # InsertQueryParser.parse => table_id, raw_data
      # InsertQueryValidator.validate => table, columns
      # InsertQueryTypeConvertor.convert => data
      # InsertQueryExecutor.execute => Mongo
      validate_reg_exp ||
      validate_table_exists ||
      validate_number_of_columns ||
      validate_column_types
    end

    private

    def validate_reg_exp
      @match = REG_EXP.match(query)
      unless @match.present?
        errors << "Query has syntax errors."
        return false
      end
      true
    end

    def validate_table_exists
      table_id = @match[1].to_i
      @table = Table.with_columns.first(conditions: { id: table_id } )
      unless @table.present?
        errors << "Table with id #{table_id} does not exist."
        return false
      end
      true
    end

    def validate_number_of_columns
      @columns = @table.columns
      keys = split_entries(@match[2])
      values = split_entries(@match[3])

      @columns.each do |c|
        unless keys.include?(c.name)
          errors << "Column #{c.name} is missing."
          return false
        end
      end

      unless (@columns.length == keys.length) && (@columns.length == values.length)
        errors << "Number of columns or values does not match with definition."
        return false
      end
      @raw_data = hash_from_pairs(keys, values)
      true
    end

    def validate_column_types
      @data = {}
      @columns.each do |c|
        column_name = c.name
        converted_value = c.class.convert(@raw_data[column_name])

        unless converted_value.present?
          errors << "Column #{column_name} is not of type #{c.class.name}."
          return false
        end

        @data[column_name] = converted_value
      end
      true
    end

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
