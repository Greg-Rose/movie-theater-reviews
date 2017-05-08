class Vote < ApplicationRecord
  belongs_to :review
  belongs_to :user

  validates :review_id, presence: true
  validates :user_id, presence: true
end
