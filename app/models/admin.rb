class Admin < ApplicationRecord
  has_secure_password

  validates :fullName, :email, presence: true
end
