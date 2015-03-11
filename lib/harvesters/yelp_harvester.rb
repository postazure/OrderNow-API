class YelpHarvester
  def initialize restaurant
    yelp_business_id = get_yelp_id(restaurant.yelp_url)
    Yelp.client.business(yelp_business_id)
  end

  def get_yelp_id url
    url.slice!("http://www.yelp.com/biz/")
    return url
  end
end
