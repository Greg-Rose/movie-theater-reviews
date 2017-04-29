class MovieTheater < ApplicationRecord
  has_many :reviews
  belongs_to :state
  belongs_to :user

  validates :name, presence: true
  validates :city, presence: true
  validates :state_id, presence: true
  validates :zipcode, length: { is: 5, allow_nil: true, allow_blank: true }
  validates :user_id, presence: true
  validates :website, url: { allow_nil: true, allow_blank: true }
end
