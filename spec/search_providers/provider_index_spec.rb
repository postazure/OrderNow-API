require 'rails_helper'
require 'search_providers/provider_index'
require 'search_providers/search_provider'
require 'search_providers/order_ahead_provider'

describe 'restaurant namespace rake task' do
  let(:all_providers) {ProviderIndex.providers}

  describe "provide context" do
    it "returns provider list" do
      expect(all_providers.class).to be Array
      expect(all_providers).to include "order_ahead"
    end

    it "returns search origin" do
      location = ProviderIndex.origin
      expect(location["lat"]).to be_within(0.00001).of(37.7717185)
      expect(location["lng"]).to be_within(0.00001).of(-122.4438929)
    end
  end

  describe "save records to database" do
    let(:records) {[
      Restaurant.new({
        name: "Test Name",
        phone_number: "123-123-1234",
        source_name: "Test Service",
        source_url: "https://www.orderaheadapp.com/places/ovo-cafe--san-francisco-ca.json?client_name=computer",
        logo_url: "https://d3de9ulu7b6z6y.cloudfront.net/uploads/store/logo/1660/thumb_ovo_cafe.png",
        delivery_hours_start: "8:00 AM",
        delivery_hours_end: "3:00 PM",
        yelp_url: "http://www.yelp.com/biz/ovo-cafe-san-francisco"
      }),
    ]}

    describe "save a single record" do
      it "saves a record that does not exist [new]" do
        ProviderIndex.save(records)

        db_restaurants_after = Restaurant.all
        expect(db_restaurants_after.length).to eq 1
      end

      it "saves a record" do
        report = ProviderIndex.save(records)

        expect(report[:records]).to eq 1
        expect(report[:created]).to eq 1
        expect(report[:updated]).to eq 0
        expect(report[:matched]).to eq 0
      end
    end

    describe "update a record" do
      it "updates a record that exists [update]" do
        records.push(Restaurant.new({
          name: "Test Name",
          phone_number: "345-345-3456",
          source_name: "Test Service",
          source_url: "https://www.orderaheadapp.com/places/ovo-cafe--san-francisco-ca.json?client_name=computer",
          logo_url: "https://d3de9ulu7b6z6y.cloudfront.net/uploads/store/logo/1660/thumb_ovo_cafe.png",
          delivery_hours_start: "8:00 AM",
          delivery_hours_end: "3:00 PM",
          yelp_url: "http://www.yelp.com/biz/ovo-cafe-san-francisco"
        }))
        ProviderIndex.save(records)
        db_restaurant = Restaurant.find_by name: "Test Name"

        expect(db_restaurant.phone_number).to eq "345-345-3456"  
      end

      it "needs to update a record" do
        records.push(Restaurant.new({
          name: "Test Name",
          phone_number: "345-345-3456",
          source_name: "Test Service",
          source_url: "https://www.orderaheadapp.com/places/ovo-cafe--san-francisco-ca.json?client_name=computer",
          logo_url: "https://d3de9ulu7b6z6y.cloudfront.net/uploads/store/logo/1660/thumb_ovo_cafe.png",
          delivery_hours_start: "8:00 AM",
          delivery_hours_end: "3:00 PM",
          yelp_url: "http://www.yelp.com/biz/ovo-cafe-san-francisco"
        }))
        report = ProviderIndex.save(records)

        expect(report[:records]).to eq 2
        expect(report[:created]).to eq 1
        expect(report[:updated]).to eq 1
        expect(report[:matched]).to eq 0

        db_restaurants_after = Restaurant.all
        expect(db_restaurants_after.length).to eq 1
      end
    end

    it "does NOT save a record that exists [exact]"

  end
end
