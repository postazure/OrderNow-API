class ProviderIndex
  def self.providers
    [
      "order_ahead",
    ]
  end

  def self.order_ahead
    provider = OrderAheadProvider.new(self.origin)
    response = provider.search_by_location
    restaurants = provider.to_restaurants(response)
    self.save(restaurants)
    db_restaurants = Restaurant.where(yelp_url: nil)
    provider.get_yelp_urls(db_restaurants)

    return restaurants
  end

  def self.save records
    records.each do |restaurant|
      if restaurant.save
        puts "[ProviderIndex#save] Record ##{restaurant.id} Saved: #{restaurant.name}"
      else
        # Update Records Here
        # db_restaurant = Restaurant.find_by name: restaurant.name
        # db_restaurant.diff(restaurant).each do |difference|
        #   db_restaurant.update_attribute(difference.to_sym, restaurant.send(difference))
        # end
      end
    end
  end

  def self.origin
    # begin
    #   origin = Geocoder.search(94117).first
    #   origin.geometry["location"]
    # rescue
    #   {"lat"=>37.7717185, "lng"=>-122.4438929} # San Francisco, CA
    # end
    {"lat"=>37.7717185, "lng"=>-122.4438929}
  end
end
