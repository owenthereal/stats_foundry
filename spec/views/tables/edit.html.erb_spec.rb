require 'spec_helper'

describe "tables/edit.html.erb" do
  before(:each) do
    @table = assign(:table, stub_model(Table,
      :name => "MyString"
    ))
  end

  it "renders the edit table form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tables_path(@table), :method => "post" do
      assert_select "input#table_name", :name => "table[name]"
    end
  end
end
