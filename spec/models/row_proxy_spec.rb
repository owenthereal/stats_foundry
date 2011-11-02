require 'spec_helper'

describe RowProxy do
  context "with a table" do
    let(:table) { Factory.create(:table) }

    it "constructs collection name" do
      RowProxy.collection_name(table).should == "Table_#{table[:id]}_Row"
    end

    it "constructs collection class" do
      proxy_class = RowProxy.of(table)
      proxy_class.ancestors.should include(Mongoid::Document)

      proxy_class.create("foo" => "bar")
      proxy_class.all.size.should == 1
      proxy_class.first.foo.should == "bar"
    end
  end
end
