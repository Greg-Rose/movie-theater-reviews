FactoryGirl.define do
  factory :review do
    sequence(:title) { |n| "Super Cool#{n}" }
    sequence(:body) { |n| "Etc. etc. etc. #{n}" }
    rating 3

    user
    movie_theater
  end
end
