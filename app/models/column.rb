class Column < ActiveRecord::Base
  TYPES = [ IntegerColumn.name, TextColumn.name, DateTimeColumn.name ]

  belongs_to :table, :dependent => :destroy

  validates_presence_of :name
  validates_inclusion_of :type, :in => TYPES

end
