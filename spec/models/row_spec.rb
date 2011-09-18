require 'spec_helper'

describe Row do
  context "with a table" do
    let(:table) { Factory.create(:table) }

    it "constructs collection name" do
      Row.collection_name(table).should == "Table_#{table[:id]}_Row"
    end

    it "constructs collection class" do
      collection_class = Row.collection_class(table)
      collection_class.should == "Table_#{table[:id]}_Row".constantize
      collection_class.ancestors.should include(MongoMapper::Document)
    end
  end
end
