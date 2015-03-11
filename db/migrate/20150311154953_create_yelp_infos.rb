class CreateYelpInfos < ActiveRecord::Migration
  def change
    create_table :yelp_infos do |t|
      t.float :rating
      t.string :rating_image_url
      t.integer :review_count
      t.string :snippet_text
      t.string :snippet_image_url
      t.integer :restaurant_id

      t.timestamps
    end
  end
end
