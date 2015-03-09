require 'rails_helper'
require 'search_providers/provider_index'
require 'search_providers/search_provider'
require 'search_providers/order_ahead_provider'

describe 'restaurant namespace rake task' do
  let(:all_providers) {ProviderIndex.providers}
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
