require 'spec_helper'

describe Query do
  it "parses the INSERT statement" do
    query = "INSERT INTO 274409 (Product, Inventory) VALUES ('Red Shoes', 25);"
    insert_query = Query.parse(query)
    insert_query.class.should == InsertQuery
    insert_query.data.size.should == 2
    { "Product" => "Red Shoes", "Inventory" => 25 }.each do |key, value|
      insert_query.data[key].should == value
    end
  end
end
