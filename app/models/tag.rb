class Tag < ActiveRecord::Base
  has_and_belongs_to_many :restaurants, join_table: :restaurants_tags
end
