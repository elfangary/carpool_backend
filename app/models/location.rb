class Location < ApplicationRecord
     has_many :stop_points, dependent: :destroy
end
