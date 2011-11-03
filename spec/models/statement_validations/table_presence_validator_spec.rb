require 'spec_helper'

describe StatementValidations::TablePresenceValidator do
  let(:table) { Factory(:table) }
  let(:statement_with_table_present) { Statement::InsertRow.new(table_id: table.id, row_data: {}) }
  let(:statement_with_table_absent) { Statement::InsertRow.new(table_id: 1234, row_data: {}) }
  let(:validator) { StatementValidations::TablePresenceValidator.new(table_id: :table_id) }

  it "checks if table presents" do
    validator.validate(statement_with_table_present).should be
  end

  it "checks if table absents" do
    validator.validate(statement_with_table_absent).should  be_false
    statement_with_table_absent.errors.size.should == 1
    statement_with_table_absent.errors.first.should == "Table 1234 does not exist."
  end
end
