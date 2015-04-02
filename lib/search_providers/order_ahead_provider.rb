class OrderAheadProvider < SearchProvider
  def initialize search_origin
    @max_results = 1000
    @lat = search_origin["lat"]
    @lng = search_origin["lng"]
    @host = "https://www.orderaheadapp.com/"
    @slug = "--san-francisco-ca.json"
  end

  def search_by_location
    search_prefix = "api/v1.0.6/stores/search/?query="
    search_suffix  = "&page=1&per=#{@max_results}&ext=&delivers_to=true&pickup_at=&open_now="
    location = "&lat=#{@lat}&lon=#{@lng}"
    url = @host + search_prefix + search_suffix + location

    restaurants_index = get_json(url)
  end

  def find_by_id url
    sleep(1.second) unless Rails.env.test?
    get_json(url)
  end

  def to_restaurants data
    restaurants = []
    data["stores"].each_with_index do |restaurant, i|
      # puts "[OrderAheadProvider#to_restaurant] Creating record for #{restaurant["name"]}. (#{i})"
      hours = open_hours(restaurant["hours_today"])
      new_restaurant = Restaurant.new({
        name: restaurant["name"],
        phone_number: restaurant["phone_number"],
        source_name: "Order Ahead",
        source_url: @host + "places/"+ restaurant["slug"] + ".json?client_name=computer",
        logo_url: restaurant["logo_thumb_url"],
        delivery_hours_start: hours["start"],
        delivery_hours_end: hours["end"],
      })
      restaurants << new_restaurant
    end
    return restaurants
  end

  def get_yelp_urls records
    records.each do |restaurant|
      next if restaurant.yelp_url
      print "[Adding Yelp URL] #{restaurant.name}, Saved: "
      restaurant_hash = find_by_id(restaurant.source_url)
      puts restaurant.update({yelp_url:restaurant_hash["yelp_url"]}) if restaurant_hash.has_key?("yelp_url")
    end
  end

  def open_hours data
    hours = data[5..-1].split("-").map {|x| x.strip}
    {"start" => hours[0], "end" => hours[1]}
  end
end
