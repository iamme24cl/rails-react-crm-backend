class Prospect < ApplicationRecord
  validates :first_name, :last_name, :email, presence: true 
  validates :email, uniqueness: true 
  validates :stage, inclusion: { in: %w(lead contacted diligence closed rejected),
    message: "%{value} is not a valid stage" }
  belongs_to :company, optional: true
end
