FactoryGirl.define do
  factory :list do
    sequence(:name) { |n| "Shopping List #{n}" }
    permissions 'open'
  end
end
