require 'rails_helper'
require 'harvesters/harvester_index'
require 'harvesters/yelp_harvester'

describe HarvesterIndex do
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

  it "has harvesters in index" do
    expect(HarvesterIndex.harvesters).to include "yelp"
  end

  it "calls harvesters in in index" do
    test_restaurant = restaurant

    harvesters = HarvesterIndex.harvesters

    harvesters.each do |harvester|
      VCR.use_cassette("harvester #{harvester}") do
        HarvesterIndex.send(harvester)
      end
    end

    expect(test_restaurant.tags.first.text).to include("cafes")
    expect(test_restaurant.tags.second.text).to include("bakeries")
    expect(test_restaurant.tags.third.text).to include("chinese")

    expect(restaurant.yelp_info.rating).to eq 3.5
    expect(restaurant.yelp_info.review_count).to eq 134
    expect(restaurant.yelp_info.snippet_text).to include "I love this place"
    expect(restaurant.yelp_info.snippet_image_url).to include "http://s3-media2.fl.yelpcdn.com/"
  end
end
