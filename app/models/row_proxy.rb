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
      Class.new do
        include Mongoid::Document

        store_in collection_name.to_sym

        def self.name
          collection_name
        end
      end
    end
  end
end
