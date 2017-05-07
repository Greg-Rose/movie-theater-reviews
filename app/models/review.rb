class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie_theater
  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true
  validates :title, length: { maximum: 75 }
  validates :body, presence: true
  validates :body, length: { maximum: 2000 }
  validates :user_id, presence: true
  validates :movie_theater_id, presence: true
  validates :rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5, integer_only: true, message: "must be selected" }

  def helpful_votes
    votes.where(helpful: true).count
  end
end
