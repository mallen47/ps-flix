class User < ApplicationRecord

  before_save :format_username, :format_email, :set_slug

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

  def to_param
    username
  end

    private
      def format_username
        self.username = username.downcase
      end

      def format_email
        self.email = email.downcase
      end

      def set_slug
        self.slug = username.parameterize
      end
end
