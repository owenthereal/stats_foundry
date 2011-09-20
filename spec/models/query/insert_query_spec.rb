require 'spec_helper'

describe Query::InsertQuery, :broken => true do
  let(:valid_query) { Query::InsertQuery.new(valid_query_string) }
  let(:invalid_query) { Query::InsertQuery.new(invalid_query_string) }

  describe "#validate_reg_exp" do
    let(:valid_query_string) { "INSERT INTO 274409 (Product, Inventory) VALUES ('Red Shoes', 25);" }
    let(:invalid_query_string) { "INSERT INTO table_name (Product, Inventory) VALUES ('Red Shoes', 25);" }

    it "returns true for valid query" do
      valid_query.send(:validate_reg_exp).should == true
    end

    it "returns false for invalid query" do
      invalid_query.send(:validate_reg_exp).should == false
    end
  end

  context "with valid reg exp" do
    before :each do
      valid_query.send(:validate_reg_exp)
      invalid_query.send(:validate_reg_exp)
    end

    describe "#validate_table_exists" do
      let(:table) { Factory(:table) }
      let(:valid_query_string) { "INSERT INTO #{table[:id]} (Product, Inventory) VALUES ('Red Shoes', 25);" }
      let(:invalid_query_string) { "INSERT INTO 274409 (Product, Inventory) VALUES ('Red Shoes', 25);" }

      it "returns true for valid query" do
        valid_query.send(:validate_table_exists).should == true
      end

      it "returns false for invalid query" do
        invalid_query.send(:validate_table_exists).should == false
      end
    end

    context "with table exists" do
      before :each do
        valid_query.send(:validate_table_exists)
        invalid_query.send(:validate_table_exists)
        invalid_query2.send(:validate_reg_exp)
        invalid_query2.send(:validate_table_exists)
      end

      let(:column) { Factory('column/text_column') }

      describe "#validate_number_of_columns" do
        let(:valid_query_string) { "INSERT INTO #{column.table_id} (#{column.name}) VALUES ('Red Shoes');" }
        let(:invalid_query_string) { "INSERT INTO #{column.table_id} (Product) VALUES ('Red Shoes');" }
        let(:invalid_query_string2) { "INSERT INTO #{column.table_id} (#{column.name}, Inventory) VALUES ('Red Shoes', 25);" }
        let(:invalid_query2) { Query::InsertQuery.new(invalid_query_string2) }

        it "returns true for valid query" do
          valid_query.send(:validate_number_of_columns).should == true
        end

        it "returns false for invalid query" do
          invalid_query.send(:validate_number_of_columns).should == false
          invalid_query2.send(:validate_number_of_columns).should == false
        end

        context "with valid number of columns" do
          before :each do
            valid_query.send(:validate_number_of_columns)
            invalid_query.send(:validate_number_of_columns)
          end

          let(:valid_query_string) { "INSERT INTO #{column.table_id} (#{column.name}) VALUES ('Red Shoes');" }
          let(:invalid_query_string) { "INSERT INTO #{column.table_id} (#{column.name}) VALUES (25);" }

          it "returns true for valid query" do
            valid_query.send(:validate_column_types).should == true
          end

          it "returns false for invalid query" do
            invalid_query.send(:validate_column_types).should == false
          end
        end
      end
    end
  end
end
