class Column < ActiveRecord::Base
  belongs_to :table, :dependent => :destroy
end
