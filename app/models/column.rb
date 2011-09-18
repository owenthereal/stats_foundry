class Column < ActiveRecord::Base
  TYPES = [ DateTimeColumn.name, NumberColumn.name, TextColumn.name ]

  belongs_to :table, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => { :scope => [:table_id] }
  validates_inclusion_of :type, :in => TYPES
end
