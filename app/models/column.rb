class Column < ActiveRecord::Base
  TYPES = [ DateTimeColumn, NumberColumn, TextColumn ]
  TYPE_NAMES = TYPES.collect(&:name)

  belongs_to :table, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: [:table_id] }
  validates_inclusion_of :type, in: TYPE_NAMES

  def self.convert_data_types(values)
    values.collect do |v|
      converted_value = nil
      TYPES.find do |t|
        converted_value = t.convert(v)
      end

      # Returns the original value if it can't be converted
      converted_value || v
    end
  end
end
