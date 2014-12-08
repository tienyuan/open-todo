FactoryGirl.define do
  factory :api_key do
    user_id 1
    access_token 'secrettoken'
  end
end
