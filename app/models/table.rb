class Table < ActiveRecord::Base
  belongs_to :user, :dependent => :destroy
  has_many :columns
end
