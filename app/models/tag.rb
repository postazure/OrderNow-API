class Tag < ActiveRecord::Base
  validates :text, uniqueness: true
  has_and_belongs_to_many :restaurants, join_table: :restaurants_tags
end
