require 'rails_helper'
require 'harvesters/yelp_harvester'

describe YelpHarvester do
  let(:restaurant) do
    Restaurant.create!({
      name: "Test Name",
      phone_number: "123-123-1234",
      source_name: "Test Service",
      source_url: "https://www.orderaheadapp.com/places/ovo-cafe--san-francisco-ca.json?client_name=computer",
      logo_url: "https://d3de9ulu7b6z6y.cloudfront.net/uploads/store/logo/1660/thumb_ovo_cafe.png",
      delivery_hours_start: "8:00 AM",
      delivery_hours_end: "3:00 PM",
      yelp_url: "http://www.yelp.com/biz/ovo-cafe-san-francisco"
    })
  end

  it "get yelp id from yelp_url" do
    VCR.use_cassette('yelp') do
      yelp_harvester = YelpHarvester.new(restaurant)
      yelp_id = yelp_harvester.get_yelp_id(restaurant.yelp_url)

      expect(yelp_id).to eq "ovo-cafe-san-francisco"
    end
  end

  describe "it gets data from yelp" do
    it "gets ratings"

    it "gets review_count"

    it "gets snippet_text"

    it "gets snippet_image_url"

    it "gets tags (categories)"

  end

  describe "it saves data associated with a record" do
    it "saves ratings"

    it "saves tags and associates them to a model"
  end
end
