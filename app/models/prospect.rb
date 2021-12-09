class Prospect < ApplicationRecord
  validates :first_name, :last_name, :email, presence: true 
  validates :email, uniqueness: true 
  validates :stage, inclusion: { in: %w(lead contacted diligence closed rejected),
    message: "%{value} is not a valid stage" }
  belongs_to :company, optional: true
  before_save :normalize_attribute

  def normalize_attribute
    self.email = self.email.downcase
  end
end
