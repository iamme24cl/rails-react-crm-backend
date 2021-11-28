class Company < ApplicationRecord
  validates :name, presence: true, uniqueness: true 
  has_many :prospects
  before_save :normalize_attribute

  def normalize_attribute
    self.name = self.name.downcase
  end
end
