FactoryGirl.define do
  factory :movie_theater do
    sequence(:name) { |n| "Showcase Cinemas#{n}" }
    sequence(:address) { |n| "12#{n} Main Street" }
    sequence(:city) { |n| "Boston#{n}" }
    zipcode "01234"
    sequence(:website) { |n| "www.test#{n}.com" }

    user
  end
end
