module StatementValidations
  class ColumnDefinitionValidator < Base
    def validate(statement)
      column_names = Set.new(statement[:columns].collect { |c| c.name })
      statement_columns_names = Set.new(statement[:row_data].keys)

      missing_column_names = column_names.difference(statement_columns_names)
      missing_column_names.each { |name| statement.errors << "Column #{name} is missing."}

      undefined_column_names = statement_columns_names.difference(column_names)
      undefined_column_names.each { |name| statement.errors << "Column #{name} is undefined." }

      (missing_column_names.any? || undefined_column_names.any?) ? false : true
    end
  end
end
