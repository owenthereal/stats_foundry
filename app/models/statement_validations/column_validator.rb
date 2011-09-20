module StatementValidations
  class ColumnValidator < Base
    def validate(statement)
      column_names = Set.new(statement[:columns].collect { |c| c.name })
      statement_colunns_names = Set.new(statement[:row_data].keys)

      missing_column_names = column_names.difference(statement_colunns_names)
      missing_column_names.each { |name| statement.errors << "Column #{name} is missing."}

      extra_column_names = statement_colunns_names.difference(column_names)
      extra_column_names.each { |name| statement.errors << "Column #{name} is undefined." }

      (missing_column_names.any? || extra_column_names.any?) ? false : true
    end
  end
end
