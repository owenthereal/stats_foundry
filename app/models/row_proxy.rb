class RowProxy
  class << self
    def of(table)
      collection_name = collection_name(table)
      collection_name.constantize rescue create_proxy_class(collection_name)
    end

    def collection_name(table)
      "Table_#{table[:id]}_Row"
    end

    def create_proxy_class(collection_name)
      proxy_class = Class.new do
        include MongoMapper::Document
      end
      Object.const_set(collection_name, proxy_class)
    end
  end
end
