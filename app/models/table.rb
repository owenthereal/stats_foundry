class Table < ActiveRecord::Base
  belongs_to :user, :dependent => :destroy
  has_many :columns

  validates_presence_of :name
end
