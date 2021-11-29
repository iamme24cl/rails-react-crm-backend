class User < ApplicationRecord
  has_many :sessions, as: :bearer

  validates :email, presence: true, uniqueness: true 
  has_secure_password
end
