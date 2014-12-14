class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :posts
  validates_confirmation_of :password, message: "Ambos campos deben coincidir", if: :password
   validates :password, length: { minimum: 6 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true
  validates :username, uniqueness: true
end
