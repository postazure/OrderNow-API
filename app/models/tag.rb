class Tag < ActiveRecord::Base
  has_many :restaurant_to_tags
  has_many :restaurants, through: :restaurant_to_tags

end
