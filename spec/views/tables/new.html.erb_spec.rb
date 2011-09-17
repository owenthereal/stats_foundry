require 'spec_helper'

describe "tables/new.html.erb" do
  before(:each) do
    assign(:table, stub_model(Table,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new table form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tables_path, :method => "post" do
      assert_select "input#table_name", :name => "table[name]"
    end
  end
end
