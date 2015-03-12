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

  describe "request with no search params" do

    it "returns restaurants data" do
      db_restaurant.save!
      get restaurants_path, {}, {"Accept" => "application/json"}
      expect(response.status).to eq 200
      body = JSON.parse(response.body)
      json_restaurant = body["results"].first

      expect(json_restaurant["id"]).to eq db_restaurant.id
      expect(json_restaurant["name"]).to eq "Ovo Cafe"
      expect(json_restaurant["source_url"]).to eq "https://www.orderaheadapp.com/places/ovo-cafe--san-francisco-ca"
      expect(json_restaurant["delivery_hours_start"]).to eq 480
      expect(json_restaurant["delivery_hours_end"]).to eq 1230
    end

    it "returns restaurants only! core data" do
      db_restaurant.save!
      get restaurants_path, {}, {"Accept" => "application/json"}
      expect(response.status).to eq 200
      body = JSON.parse(response.body)
      json_restaurant = body["results"].first

      expect(json_restaurant["source_name"]).to be nil
      expect(json_restaurant["logo_url"]).to be nil
      expect(json_restaurant["yelp_url"]).to be nil
      expect(json_restaurant["redis_key"]).to be nil
      expect(json_restaurant["created_at"]).to be nil
      expect(json_restaurant["updated_at"]).to be nil
    end

    it "returns records_found" do
      db_restaurant.save!
      get restaurants_path, {}, {"Accept" => "application/json"}
      expect(response.status).to eq 200
      body = JSON.parse(response.body)

      expect(body["records_found"]).to be true
    end
  end

  describe "one word search term" do
    describe "request with query params" do
      it "does not return unrelated results" do
        db_restaurant.save!
        get restaurants_path, {"k" => "bar"}, {"Accept" => "application/json"}
        # p request.query_string
        # p request.url
        expect(response.status).to eq 200

        body = JSON.parse(response.body)
        json_restaurant = body["results"].first

        # p body
        expect(body["records_found"]).to be false
        expect(body["results"]).to be_empty
      end

      it "returns a relavent result" do
        db_restaurant.save!
        VCR.use_cassette('yelp') do
          HarvesterIndex.yelp
        end

        get restaurants_path, {"k" => "chinese"}, {"Accept" => "application/json"}
        expect(response.status).to eq 200

        body = JSON.parse(response.body)
        p body
        json_restaurant = body["results"].first
        # p body
        expect(body["records_found"]).to be true
        expect(json_restaurant["id"]).to eq db_restaurant.id
        expect(json_restaurant["name"]).to eq "Ovo Cafe"
      end
    end
  end
end
