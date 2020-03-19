class Review < ApplicationRecord
  belongs_to :movie

  validates :name, presence: true
  validates :comment, length: { minimum: 4 }
  STARS = (1..5).to_a
  validates :stars, inclusion: {
  	in: STARS,
  	message: 'Must be between 1 and 5'
  }
end
