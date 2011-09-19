require 'spec_helper'

describe StatementParser::InsertRow do
  let(:valid_query_string) { "INSERT INTO 274409 (Product, Inventory) VALUES ('Red Shoes', 25);" }
  let(:invalid_query_string) { "INSERT INTO table_name (Product, Inventory) VALUES ('Red Shoes', 25);" }

  let(:parser) { StatementParser::InsertRow }

  it "parses valid query" do
    statement = parser.parse(valid_query_string)
    statement.table_id.should == 274409
    statement.raw_data.size.should == 2
    { 'Product' => "'Red Shoes'", 'Inventory' => '25' }.each { |k, v| statement.raw_data[k].should == v }
  end

  it "parses invalid query and reports errors" do
    parser.parse(invalid_query_string).should be_nil
  end
end
