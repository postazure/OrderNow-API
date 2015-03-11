class YelpHarvester
  def initialize restaurant
    @restaurant = restaurant
    yelp_business_id = get_yelp_id(restaurant.yelp_url)
    @yelp_data = Yelp.client.business(yelp_business_id)
  end

  def get_yelp_id url
    url.slice!("http://www.yelp.com/biz/")
    return url
  end

  def populate_data
    yelp_info = YelpInfo.new({
      rating: @yelp_data.rating,
      rating_image_url: @yelp_data.rating_img_url,
      review_count: @yelp_data.review_count,
      snippet_text: @yelp_data.snippet_text,
      snippet_image_url: @yelp_data.snippet_image_url,
      restaurant_id: @restaurant.id,
    })

    yelp_info.save
  end

  def populate_tags
    @yelp_data.categories.each do |capitolized_tag, downcased_tag|
      puts downcased_tag
      @restaurant.tags.create!({
        text: downcased_tag
      })
    end

  end
end
