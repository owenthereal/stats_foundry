module Statement
  class InsertRow
    attr_reader :table_id, :raw_data, :data, :table, :columns

    def initialize(table_id, raw_data)
      @table_id = table_id
      @raw_data = raw_data
      @data = {}
      @table = Table.with_columns.first(:conditions => { :id => table_id } )
      @columns = @table ? @table.columns : []
    end

    def valid?
      errors.clear
      validate
      convert_data_types
      errors.any?
    end

    def execute
      valid? ? execute! : false
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
