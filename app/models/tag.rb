class Tag < ActiveRecord::Base
  validates :text, uniqueness: true, scope: :restaurant_id
  belongs_to :restaurants
end
