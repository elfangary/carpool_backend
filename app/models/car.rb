class Car < ApplicationRecord

  # has_many :trips
  # belongs_to :user

  validates :model, :color, :number, presence: true
end
