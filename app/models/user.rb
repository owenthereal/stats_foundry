class User < ActiveRecord::Base
  include Clearance::User

  attr_accessible :email, :password, :password_confirmation

  validates_confirmation_of :password
end
