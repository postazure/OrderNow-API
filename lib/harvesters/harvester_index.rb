class HarvesterIndex
  def self.harvesters
    [
      "yelp",
    ]
  end

  def self.yelp
    restaurants = Restaurant.where.not(yelp_url: nil)

    restaurants.each do |restaurant|
      yelp_harvester = YelpHarvester.new(restaurant)
      yelp_harvester.populate_data
      yelp_harvester.populate_tags
    end
  end
end
