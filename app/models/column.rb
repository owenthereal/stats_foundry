class Column < ActiveRecord::Base
  TYPES = [ IntegerColumn.name, TextColumn.name, DateTimeColumn.name ]

  belongs_to :table, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => { :scope => [:table_id] }
  validates_inclusion_of :type, :in => TYPES
end
