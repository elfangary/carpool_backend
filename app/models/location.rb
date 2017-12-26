class Location < ApplicationRecord
     has_many :stop_points, dependent: :destroy

     validates :name, presence: true
end
