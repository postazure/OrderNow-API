class YelpHarvester
  def initialize restaurant
    @restaurant = restaurant
    yelp_business_id = get_yelp_id(restaurant.yelp_url)
    puts "[YelpHarvester#initialize] Contacting yelp api for: #{yelp_business_id}"
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

    is_saved = yelp_info.save
    if is_saved
      puts "[YelpHarvester#populate_data] Saved yelp data for: #{@restaurant.name}"
    else
      puts "[YelpHarvester#populate_data] Error while saving yelp data for: #{@restaurant.name}"
    end
    return is_saved
  end

  def populate_tags
    @yelp_data.categories.each do |capitolized_tag, downcased_tag|
      tag = @restaurant.tags.create({
        text: capitolized_tag
      })
      if tag.persisted?
        puts "[YelpHarvester#populate_tags] Saved tags for: #{@restaurant.name} Tag: #{tag.text}"
      else
        puts "[YelpHarvester#populate_tags] Error while saving tags for: #{@restaurant.name} Tag: #{tag.text}"
      end
    end
  end
end
