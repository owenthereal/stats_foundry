require 'spec_helper'

describe Column do
  describe "#convert_data_types" do
    it "converts values to defined data types" do
      types = ['2011-08-02', '-130.222', '"a string"', "'another string'"]
      converted_types = Column.convert_data_types(types)
      converted_types.should == [ Time.zone.parse('2011-08-02'), -130.222, 'a string', 'another string' ]
    end

    it "preserves values of undefined data types" do
      types = ['2011-08-1', '-130.r', '\'a string"']
      converted_types = Column.convert_data_types(types)
      converted_types.should == types
    end
  end
end
