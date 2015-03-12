class RestaurantsController < ApplicationController
  def index
    return_records = {
    records_found: false,
    results:[],
    }
    # puts "before"
    if params["k"]
      keywords = extract_keywords(params["k"])
      tag_results = search_by_tag(keywords)
      # need to add search by name
      tagged_restaurants = tag_results.map {|tag| tag}
      return_records[:results].push(index_serializer(tagged_restaurants))
      return_records[:results].flatten!.compact!
    else
      return_records[:results] = index_serializer(Restaurant.all)
    end
    return_records[:records_found] = true unless return_records[:results].empty?
    render json: return_records
  end

  private
  def search_by_tag keywords
    query = keywords.map {|x| "%#{x}%"}

    Restaurant.joins(:tags).where('text ilike any ( array[?] )', query)
  end

  def search_by_name keyword
    return Restaurant.where('NAME ILIKE ?', "%#{keyword}%")
  end

  def extract_keywords param
    param.split("+")
  end

  def index_serializer records
    include_attrs = [
      "id",
      "name",
      "source_url",
      "delivery_hours_start",
      "delivery_hours_end",
    ]

    display_records = []
    records.each do |record|
      display_record = {}
      include_attrs.each do |attribute|
        display_record[attribute] = record.send(attribute)
      end
      display_records.push(display_record)
    end
    return display_records
  end
end
