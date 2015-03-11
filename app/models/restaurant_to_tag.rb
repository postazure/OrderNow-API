class RestaurantToTag < ActiveRecord::Base
belongs_to :restaurant
belongs_to :tag

end
