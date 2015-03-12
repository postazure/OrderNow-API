class AddIntervalRankToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :interval_rank, :integer
  end
end
