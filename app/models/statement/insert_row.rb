module Statement
  class InsertRow
    attr_reader :table_id, :raw_data

    def initialize(table_id, raw_data)
      @table_id = table_id
      @raw_data = raw_data
    end

    def valid?
      errors.clear
      validate
      errors.any?
    end

    def execute
      valid? ? execute! : false
    end

    def execute!
      # push to mongo
    end
  end
end
