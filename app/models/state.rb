class State < ApplicationRecord
  has_many :movie_theaters

  validates :name, uniqueness: true
  validates :name, presence: true
  validates :abbreviation, uniqueness: true
  validates :abbreviation, presence: true
  validates :abbreviation, length: { is: 2 }
end
