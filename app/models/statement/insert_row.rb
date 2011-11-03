module Statement
  class InsertRow < Base
    validates_with StatementValidations::TablePresenceValidator, table_id: :table_id
    validates_with StatementValidations::ColumnDefinitionValidator, columns: :columns, row_data: :row_data

    def initialize(attributes = {})
      super

      attributes[:table] = Table.with_columns.first(conditions: { id: attributes[:table_id] })
      attributes[:columns] = attributes[:table].try(:columns) || {}
    end

    def execute!
      # push to mongo
    end
  end
end
