class YelpInfo < ActiveRecord::Base
  belongs_to :restaurant
  validates :restaurant_id, uniqueness: true
end
