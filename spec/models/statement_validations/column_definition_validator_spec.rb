require 'spec_helper'

describe StatementValidations::ColumnDefinitionValidator do
  let(:table) { Factory(:table) }
  let!(:text_column) { Factory(:text_column, table: table) }
  let!(:number_column) { Factory(:number_column, table: table) }
  let(:statement_with_valid_columns) { Statement::InsertRow.new(table_id: table.id, row_data: {text_column.name => "text", number_column.name => 1}) }
  let(:statement_with_missing_columns) { Statement::InsertRow.new(table_id: table.id, row_data: {text_column.name => "text"}) }
  let(:statement_with_undefined_columns) { Statement::InsertRow.new(table_id: table.id, row_data: {text_column.name => "text", number_column.name => 1, "undefined_column" => "boom"}) }
  let(:validator) { StatementValidations::ColumnDefinitionValidator.new(columns: :columns, row_data: :row_data) }

  it "checks if column definition matches" do
    validator.validate(statement_with_valid_columns).should be
  end

  it "checks if statement has missing columns" do
    validator.validate(statement_with_missing_columns).should be_false
    statement_with_missing_columns.errors.size.should == 1
    statement_with_missing_columns.errors.first.should == "Column #{number_column.name} is missing."
  end

  it "checks if statement has undefined columns" do
    validator.validate(statement_with_undefined_columns).should be_false
    statement_with_undefined_columns.errors.size.should == 1
    statement_with_undefined_columns.errors.first.should == "Column undefined_column is undefined."
  end
end
