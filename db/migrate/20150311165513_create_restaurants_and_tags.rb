class CreateRestaurantsAndTags < ActiveRecord::Migration
  def change
    create_table :restaurants_tags, id: false do |t|
      t.belongs_to :restaurant, index: true
      t.belongs_to :tag, index: true
    end
  end
end
