class RestaurantsController < ApplicationController
  def index
    return_records = {records_found: false, results:[]}
    attrs = ["id", "name", "source_name", "source_url", "delivery_hours_start", "delivery_hours_end", "interval_rank"]

    if params["k"]
      compiled_results = []
      tag_results = search_by_tag(params["k"])
      compiled_results.push(serializer(tag_results, attrs))

      name_results = search_by_name(params["k"])
      compiled_results.push(serializer(name_results, attrs))

      return_records[:results] = compiled_results.flatten.compact.uniq
    else
      return_records[:results] = serializer(Restaurant.all.order(interval_rank: :desc), attrs)
    end
    return_records[:records_found] = true unless return_records[:results].empty?
    render json: return_records
  end

  def show
    db_restaurant = Restaurant.find_by id: params["id"]
    yelp = db_restaurant.yelp_info
    tags = db_restaurant.tags

    restaurant_attrs = [
      "id",
      "name",
      "phone_number",
      "source_name",
      "source_url",
      "logo_url",
      "yelp_url",
      "delivery_hours_start",
      "delivery_hours_end",
      "interval_rank",
    ]

    tags_attrs = ["id","text"]
    yelp_attrs = ["rating","rating_image_url","review_count","snippet_text","snippet_image_url"]

    restaurant = serializer([db_restaurant], restaurant_attrs)[0]
    if restaurant["yelp_url"]
      restaurant["yelp_info"] = serializer([yelp], yelp_attrs)[0]
      restaurant["tags"] = serializer(tags, tags_attrs)
    end
    render json: restaurant
  end

  def historic
    restaurant_id = params[:id]
    wait_time = params["wait"]

    restaurant = Restaurant.find_by id:restaurant_id
    day_of_week = Time.now.strftime("%A")
    hour_of_day = Time.now.strftime("%H")
    new_count = 1
    new_avg = wait_time

    rdb_data = $redis.get("#{restaurant_id}:#{day_of_week}:#{hour_of_day}")
    begin
      rdb_hash = JSON.parse(rdb_data)
      p rdb_hash
      cur_avg = rdb_hash["avg"]
      cur_count = rdb_hash["count"].to_i
      new_count = cur_count + 1
      new_avg = (wait_time + (cur_count * cur_avg))/new_count #moving average eq.
    rescue
    end

    new_data = {"avg" => new_avg, "count" => new_count}
    if $redis.set("#{restaurant_id}:#{day_of_week}:#{hour_of_day}", new_data.to_json)
      render nothing: true, status: 200
    else
      render nothing: true, status: 522
    end
  end

  private
  def search_by_tag param
    keywords = extract_keywords(param)
    query = keywords.map {|x| "%#{x}%"}
    results = Restaurant.joins(:tags).where('text ilike any ( array[?] )', query).order(interval_rank: :desc)
    results.map{|restaurant| restaurant}
  end

  def search_by_name param
    keywords = extract_keywords(param)
    query = keywords.map {|x| "%#{x}%"}
    Restaurant.where('name ilike any ( array[?] )', query).order(interval_rank: :desc)
  end

  def extract_keywords param
    param.split("+")
  end

  def serializer records, include_attrs
    display_records = []
    records.each do |record|
      display_record = {}
      include_attrs.each do |attribute|
        begin
          display_record[attribute] = record.send(attribute)
        rescue
          next
        end
      end
      display_records.push(display_record)
    end
    return display_records
  end
end
