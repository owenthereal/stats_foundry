class Table < ActiveRecord::Base
  belongs_to :user, :dependent => :destroy
  has_many :columns

  validates_presence_of :name

  scope :with_columns, includes(:columns)

  def rows
    @rows ||= row_proxy.all
  end

  def row_proxy
    @row_proxy ||= RowProxy.of(self)
  end
end
