class MongodbCleaner
  def self.clean
    MongoMapper.database.collections.find_all {|c| c.name != 'system.indexes' }.each { |c| c.drop }
  end
end
