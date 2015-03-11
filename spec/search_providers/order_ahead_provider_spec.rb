require 'rails_helper'
require 'search_providers/provider_index'
require 'search_providers/search_provider'
require 'search_providers/order_ahead_provider'

describe 'restaurant namespace rake task' do
  # let(:order_ahead)  do
  #   VCR.use_cassette('order ahead') do
  #     ProviderIndex.order_ahead
  #   end
  # end

  describe "#to_restaurant" do
    it "returns an array of restaurant records" do
      VCR.use_cassette('order ahead') do
        restaurants = ProviderIndex.order_ahead
        all_restaurant_objects = true
        restaurants.each do |restaurant|
          all_restaurant_objects = false if restaurant.class != Restaurant
        end

        expect(all_restaurant_objects).to be true
        expect(restaurants.class).to eq Array
      end
    end
  end

  describe "#get_yelp_urls" do
    it "gets a restaurant's yelp url" do
      response = nil
      provider = nil

        VCR.use_cassette('order ahead') do
          provider = OrderAheadProvider.new({"lat"=>37.7717185, "lng"=>-122.4438929})
          response = provider.search_by_location
        end
        VCR.use_cassette('order ahead get_yelp_urls') do
          restaurants = provider.to_restaurants(response)
          provider.get_yelp_urls(restaurants)

          restaurants = Restaurant.where.not(yelp_url: nil)
          expect(restaurants.sample.yelp_url).to include "http://www.yelp.com/biz/"
        end
    end
  end
end
