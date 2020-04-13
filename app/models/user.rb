class User < ApplicationRecord
  has_secure_password
  has_many :reviews
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie
  has_many :movie_reviews, through: :reviews, source: :movie
  
  validates :name, presence: true
  validates :username, uniqueness: {case_sensitive: false}, 
            format: { with: /\w+/i }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false },
                    allow_blank: true
end
