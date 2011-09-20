module StatementValidations
  class TablePresenceValidator < StatementValidator
    def validate(statement)
      table_id = statement[options[:table_id]]
      is_exist = Table.exists?(table_id)
      if is_exist
        true
      else
        statement.errors << "Table #{table_id} does not exist."
        false
      end
    end
  end
end
