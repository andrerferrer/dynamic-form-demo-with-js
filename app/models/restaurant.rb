class Restaurant < ApplicationRecord
  STRONG_PARAMS = %i[
    name
    address
  ]
  
  has_many :reviews

  validates :name, presence: true
  validates :address, presence: true
end
