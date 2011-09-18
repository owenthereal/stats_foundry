class Query
  STRATEGIES = [ InsertQuery ]

  def self.parse(query)
    strategy = STRATEGIES.find { |s| s.match?(query) }
    strategy.new(query)
  end

  attr_reader :query, :errors, :table, :columns, :data

  def initialize(query)
    @query = query
    @errors = []
  end

  def valid?
    errors.clear
    validate
    errors.empty?
  end
end
