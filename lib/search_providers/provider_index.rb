class ProviderIndex
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
    current_status = ""
      if restaurant.save
        save_status[:created] += 1
        current_status = "Saved"
      elsif restaurant.errors[:existing].include?("update")
        db_restaurant = Restaurant.find_by name: restaurant.name
        db_restaurant.diff(restaurant).each do |difference|
          db_restaurant.update_attribute(difference.to_sym, restaurant.send(difference))
        end
        current_status = "Updated"
        save_status[:updated] += 1
      elsif restaurant.errors[:existing].include?("exact")
        current_status = "Matched"
        save_status[:matched] += 1
      end
    puts "[ProviderIndex#save] Saving record: #{restaurant.name} - #{current_status} (#{restaurant.id})"
    end
    return save_status
  end

  def self.origin
    begin
      origin = Geocoder.search(94117).first
      origin.geometry["location"]
    rescue
      {"lat"=>37.7717185, "lng"=>-122.4438929} # San Francisco, CA
    end
  end
end
