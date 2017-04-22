FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name "Smith"
    sequence(:email) { |n| "john#{n}@example.com" }
    sequence(:username) { |n| "JohnS#{n}" }
    password "password1"
    password_confirmation "password1"
  end
end
