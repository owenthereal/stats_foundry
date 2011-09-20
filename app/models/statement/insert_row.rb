module Statement
  class InsertRow < Base
    validates_with StatementValidations::TablePresenceValidator, :table_id => :table_id
    validates_with StatementValidations::ColumnValidator, :columns => :columns, :row_data => :row_data

    def initialize(attributes = {})
      super

      raise "table_id and row_data are required" unless attributes[:table_id] && attributes[:row_data]
      attributes[:table] = Table.with_columns.first(:conditions => { :id => attributes[:table_id] })
      attributes[:columns] = attributes[:table].columns if attributes[:table]
    end

    def execute!
      # push to mongo
    end

    private

    def convert_data_types
      columns.each do |c|
        column_name = c.name
        converted_value = c.class.convert(raw_data[column_name])

        if converted_value
          data[column_name] = converted_value
        else
          errors << "Column #{column_name} is not of type #{c.class.name}."
        end
      end
    end
  end
end
