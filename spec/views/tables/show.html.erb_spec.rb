require 'spec_helper'

describe "tables/show.html.erb" do
  before(:each) do
    @table = assign(:table, stub_model(Table,
      name: "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
