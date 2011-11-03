FactoryGirl.define do
  factory :column do
    sequence(:name) { |n| "column-#{n}" }
    table factory: :table
  end

  Column::TYPE_NAMES.each do |t|
    factory t.split(':').last.underscore, parent: :column do
      type { t }
    end
  end
end
