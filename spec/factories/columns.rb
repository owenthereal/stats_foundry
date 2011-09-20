FactoryGirl.define do
  factory :column do
    sequence(:name) { |n| "column-#{n}" }
    table :factory => :table

    Column::TYPE_NAMES.each do |t|
      factory t.underscore, :parent => :column do
        type { t }
      end
    end
  end
end
