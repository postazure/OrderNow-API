# require "vcr_setup"
require 'rails_helper'
require 'search_providers/provider_index'
require 'search_providers/search_provider'
require 'search_providers/order_ahead_provider'

describe 'restaurant namespace rake task' do
  let(:order_ahead)  {ProviderIndex.order_ahead}
  
  describe "#to_restaurant" do
    it "returns an array of restaurant records" do
      restaurants = order_ahead
      all_restaurant_objects = true
      restaurants.each do |restaurant|
        all_restaurant_objects = false if restaurant.class != Restaurant
      end

      expect(all_restaurant_objects).to be true
      expect(restaurants.class).to eq Array
    end
  end
end
