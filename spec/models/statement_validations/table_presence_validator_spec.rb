require 'spec_helper'

describe StatementValidations::TablePresenceValidator do
  let(:table) { Factory(:table) }
  let(:statement_with_table_present) { Statement::InsertRow.new(:table_id => table.id, :row_data => {}) }
  let(:statement_with_table_absent) { Statement::InsertRow.new(:table_id => 1234, :row_data => {}) }
  let(:validator) { StatementValidations::TablePresenceValidator.new(:table_id => :table_id) }

  it "validates table presence" do
    validator.validate(statement_with_table_present).should == true
    validator.validate(statement_with_table_absent).should == false
  end
end
