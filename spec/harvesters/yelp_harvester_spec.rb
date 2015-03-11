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

  describe "it gets data from yelp and saves it" do
    it "gets rating" do
      VCR.use_cassette('yelp') do
        yelp_harvester = YelpHarvester.new(restaurant)
        is_saved = yelp_harvester.populate_data

        expect(is_saved).to be true
        expect(restaurant.yelp_info.rating > 0).to be true
        expect(restaurant.yelp_info.rating <= 5 ).to be true
      end
    end

    it "gets review_count" do
      VCR.use_cassette('yelp') do
        yelp_harvester = YelpHarvester.new(restaurant)
        is_saved = yelp_harvester.populate_data

        expect(is_saved).to be true
        expect(restaurant.yelp_info.review_count > 0).to be true
        expect(restaurant.yelp_info.review_count.class).to be Fixnum
      end
    end

    it "gets snippet_text" do
      VCR.use_cassette('yelp') do
        yelp_harvester = YelpHarvester.new(restaurant)
        is_saved = yelp_harvester.populate_data

        expect(is_saved).to be true
        expect(restaurant.yelp_info.snippet_text.length > 0).to be true
        expect(restaurant.yelp_info.snippet_text.class).to be String
      end
    end

    it "gets snippet_image_url" do
      VCR.use_cassette('yelp') do
        yelp_harvester = YelpHarvester.new(restaurant)
        is_saved = yelp_harvester.populate_data

        expect(is_saved).to be true
        expect(restaurant.yelp_info.snippet_text.length > 0).to be true
        expect(restaurant.yelp_info.snippet_text.class).to be String
      end
    end

    it "gets tags (categories)" do
      VCR.use_cassette('yelp') do
        yelp_harvester = YelpHarvester.new(restaurant)
        yelp_harvester.populate_tags

        expect(restaurant.tags.first.text).to include("cafes")
        expect(restaurant.tags.second.text).to include("bakeries")
        expect(restaurant.tags.third.text).to include("chinese")
        expect(restaurant.tags.length > 0).to be true
      end
    end
  end
end


# VCR
# VCR.use_cassette('yelp') do
#
# end
