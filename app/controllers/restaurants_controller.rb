class RestaurantsController < ApplicationController
  def index
    return_records = {
    records_found: false,
    results:[],
    }

    if params["k"]
      compiled_results = []
      tag_results = search_by_tag(params["k"])
      compiled_results.push(index_serializer(tag_results))

      name_results = search_by_name(params["k"])
      compiled_results.push(index_serializer(name_results))

      return_records[:results] = compiled_results.flatten.compact.uniq
    else
      return_records[:results] = index_serializer(Restaurant.all)
    end
    return_records[:records_found] = true unless return_records[:results].empty?
    render json: return_records
  end

  private
  def search_by_tag param
    keywords = extract_keywords(param)
    query = keywords.map {|x| "%#{x}%"}
    results = Restaurant.joins(:tags).where('text ilike any ( array[?] )', query)
    results.map{|restaurant| restaurant}
  end

  def search_by_name param
    keywords = extract_keywords(param)
    query = keywords.map {|x| "%#{x}%"}
    Restaurant.where('name ilike any ( array[?] )', query)
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
