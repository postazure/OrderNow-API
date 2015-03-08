# require "vcr_setup"
require 'rails_helper'
require 'search_providers/provider_index'
require 'search_providers/search_provider'
require 'search_providers/order_ahead_provider'

describe 'restaurant namespace rake task' do
  let(:order_ahead)  {ProviderIndex.order_ahead}

  describe "#seach_by_location" do
    it "makes a successful api call" do
      origin = order_ahead.search_by_location
      expect(origin.keys).to include "per_page"
      expect(origin.keys).to include "success"
      expect(origin["success"]).to be true
      expect(origin.keys).to include "stores"
      expect(origin["stores"].length > 0).to be true
    end
  end

  # describe "restaurant:get_core" do
  #
  #
  # end
end
