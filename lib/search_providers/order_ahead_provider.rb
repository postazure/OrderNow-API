# require "search_provider"
class OrderAheadProvider < SearchProvider
  def initialize search_origin
    @max_results = 1000
    @lat = search_origin["lat"]
    @lng = search_origin["lng"]
    @host = "https://www.orderaheadapp.com"
    @slug = "--san-francisco-ca.json"
  end

  def search_by_location
    search_prefix = "/api/v1.0.6/stores/search/?query="
    search_suffix  = "&page=1&per=#{@max_results}&ext=&delivers_to=true&pickup_at=&open_now="
    location = "&lat=#{@lat}&lon=#{@lng}"
    url = @host + search_prefix + search_suffix + location
    
    restaurants_index = get_json(url)
  end

  # def find_by_id
  #
  # end

  def is_provider?
    true
  end
end
