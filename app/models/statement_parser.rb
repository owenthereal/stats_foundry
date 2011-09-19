module StatementParser
  PARSERS = [ StatementParser::InsertRow ]

  def self.parse(statement)
    PARSERS.find { |p| p.parse(statement) }
  end
end
