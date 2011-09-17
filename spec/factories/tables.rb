FactoryGirl.define do
  factory :table do
    user :factory => :user
    sequence(:name) { |n| "table-#{n}" }
  end
end
