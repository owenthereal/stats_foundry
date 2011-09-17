FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user-#{n}@statsfoundry.com" }
    password { "password" }
  end
end
