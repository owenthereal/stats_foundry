module StatementValidator
  class InsertRow
    def validate(statement)
      validate_table_exists(statement) && validate_column_definition(statement)
    end

    def validate_table_exists(statement)
      unless statement.table
        statement.errors << "Table #{statement.table_id} does not exist."
        return false
      end

      true
    end

    def validate_column_definition(statement)
      columns = statement.columns
      column_names = columns.collect { |c| c.name }
      statement_colunns_names = statement.raw_data.keys

      # missing columns
      column_names.each do |name|
        unless statement_colunns_names.include?(name)
          statement.errors << "Column #{name} is missing."
        end
        return false if statement.errors.any?
      end

      # extra columns
      statement_colunns_names.each do |name|
        unless column_names.include?(name)
          statement.errors << "Column #{name} is undefined."
        end
        return false if statement.errors.any?
      end

      true
    end
  end
end
