class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :phone_number
      t.string :source_name
      t.string :source_url
      t.string :logo_url
      t.string :yelp_url
      t.integer :delivery_hours_start
      t.integer :delivery_hours_end

      t.timestamps
    end
  end
end
