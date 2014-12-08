FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "myusername#{n}" }
    password 'mypassword'
  end
end
