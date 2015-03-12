require 'rails_helper'
require 'harvesters/harvester_index'
require 'harvesters/yelp_harvester'

describe "GET /restaurants" do
  let(:db_restaurant) {Restaurant.new({
    name: "Ovo Cafe",
    phone_number: "415-908-3888",
    source_name: "orderahead",
    source_url: "https://www.orderaheadapp.com/places/ovo-cafe--san-francisco-ca",
    logo_url: "https://d3de9ulu7b6z6y.cloudfront.net/uploads/store/logo/1660/thumb_ovo_cafe.png",
    yelp_url: "http://www.yelp.com/biz/ovo-cafe-san-francisco",
    delivery_hours_start: 480,
    delivery_hours_end: 1230,
  })}
  describe "restaurant show page" do
    it "returns restaurants data" do
      db_restaurant.save!
      VCR.use_cassette('yelp') do
        HarvesterIndex.yelp
      end
      get restaurant_path(db_restaurant), {}, {"Accept" => "application/json"}
      expect(response.status).to eq 200
      json_restaurant = JSON.parse(response.body)

      expect(json_restaurant["id"]).to eq db_restaurant.id
      expect(json_restaurant["name"]).to eq "Ovo Cafe"
      expect(json_restaurant["source_url"]).to eq "https://www.orderaheadapp.com/places/ovo-cafe--san-francisco-ca"
      expect(json_restaurant["delivery_hours_start"]).to eq 480
      expect(json_restaurant["delivery_hours_end"]).to eq 1230
      expect(json_restaurant["source_name"]).to eq "orderahead"
      expect(json_restaurant["logo_url"]).to eq "https://d3de9ulu7b6z6y.cloudfront.net/uploads/store/logo/1660/thumb_ovo_cafe.png"
      expect(json_restaurant["yelp_url"]).to eq "http://www.yelp.com/biz/ovo-cafe-san-francisco"
      expect(json_restaurant).to include "interval_rank"

      expect(json_restaurant).to_not include "updated_at"
      expect(json_restaurant).to_not include "created_at"
      expect(json_restaurant).to_not include "redis_key"
    end
    it "returns tags data" do
      db_restaurant.save!
      VCR.use_cassette('yelp') do
        HarvesterIndex.yelp
      end
      get restaurant_path(db_restaurant), {}, {"Accept" => "application/json"}
      expect(response.status).to eq 200
      body = JSON.parse(response.body)

      json_tags = body["tags"]

      expect(json_tags.first["text"]).to eq "cafes"
      expect(json_tags.second["text"]).to eq "bakeries"
      expect(json_tags.third["text"]).to eq "chinese"

      expect(json_tags.first).to_not include "updated_at"
      expect(json_tags.first).to_not include "created_at"
    end

    it "returns yelp_info data" do
      db_restaurant.save!
      VCR.use_cassette('yelp') do
        HarvesterIndex.yelp
      end
      get restaurant_path(db_restaurant), {}, {"Accept" => "application/json"}
      expect(response.status).to eq 200
      body = JSON.parse(response.body)

      json_yelp_info = body["yelp_info"]

      expect(json_yelp_info).to include "rating"
      expect(json_yelp_info).to include "rating_image_url"
      expect(json_yelp_info).to include "review_count"
      expect(json_yelp_info).to include "snippet_text"
      expect(json_yelp_info).to include "snippet_image_url"

      expect(json_yelp_info.first).to_not include "updated_at"
      expect(json_yelp_info.first).to_not include "created_at"
    end
  end
end
