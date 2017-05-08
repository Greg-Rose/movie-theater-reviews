FactoryGirl.define do
  factory :vote do
    helpful true

    user
    review
  end
end
