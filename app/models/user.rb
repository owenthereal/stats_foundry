class User < ActiveRecord::Base
  include Clearance::User

  has_many :tables

  attr_accessible :email, :password, :password_confirmation

  validates_confirmation_of :password
end
