class Row
  class << self
    def all_for(table)
      collection_class(table).all
    end

    def collection_name(table)
      "Table_#{table[:id]}_Row"
    end

    def collection_class(table)
      collection_name = collection_name(table)
      collection_name.constantize rescue create_collection_class(collection_name)
    end

    def create_collection_class(collection_name)
      colleciton_class = Class.new do
        include MongoMapper::Document
      end
      Object.const_set(collection_name, colleciton_class)
    end
  end
end
