# Usage:
# query = Query.parse(statement)
# query.execute if query.present? && query.valid?
class Query
  STRATEGIES = [ Query::InsertQuery ]

  def self.parse(statement)
    strategy = STRATEGIES.find { |s| s.parse?(statement) }
    strategy.present? ? strategy.new(statement) : nil
  end

  attr_reader :statement, :errors, :table, :columns, :data
  attr_accessor :table_id, :raw_data

  def initialize(statement = nil)
    @statement = statement
    @errors = []
    @raw_data = {}
    @data = {}
    @table_id, @raw_data = parse(statement)
  end

  def valid?
    errors.clear
    validate
    errors.empty?
  end

  def validate
  end
end
