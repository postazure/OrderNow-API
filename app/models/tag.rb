class Tag < ActiveRecord::Base
  validates :text, uniqueness: {scope: :restaurant_id}
  belongs_to :restaurants
end
