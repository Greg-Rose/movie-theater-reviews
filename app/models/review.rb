class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie_theater

  validates :title, presence: true
  validates :title, length: { maximum: 75 }
  validates :body, presence: true
  validates :body, length: { maximum: 2000 }
  validates :user_id, presence: true
  validates :movie_theater_id, presence: true
end
