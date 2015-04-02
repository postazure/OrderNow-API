class ConvertRestaurantTagRelationship < ActiveRecord::Migration
  def change
    drop_table :restaurants_tags

    add_column :tags, :restaurant_id, :integer
  end
end
