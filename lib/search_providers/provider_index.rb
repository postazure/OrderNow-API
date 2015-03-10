class ProviderIndex

  def self.origin
    begin
      origin = Geocoder.search(94117).first
      origin.geometry["location"]
    rescue
      {"lat"=>37.7717185, "lng"=>-122.4438929} # San Francisco, CA
    end
  end

  def self.providers
    [
      "order_ahead",
    ]
  end

  def self.order_ahead
    provider = OrderAheadProvider.new(self.origin)
    response = provider.search_by_location
    provider.to_restaurants(response)
  end

  def self.save records
    save_status = {records: 0, created: 0, updated: 0, matched: 0}
    save_status[:records] = records.length
    records.each do |restaurant|
      if restaurant.save
        save_status[:created] += 1
      elsif restaurant.errors[:existing].include?("update")
        db_restaurant = Restaurant.find_by name: restaurant.name
        db_restaurant.diff(restaurant).each do |difference|
          db_restaurant.update_attribute(difference.to_sym, restaurant.send(difference))
        end
        save_status[:updated] += 1
      elsif restaurant.errors[:existing].include?("exact")
        save_status[:matched] += 1
      end
    end

    return save_status
  end
end
