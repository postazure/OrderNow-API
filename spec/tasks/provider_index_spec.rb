require 'rails_helper'
require 'search_providers/provider_index'
require 'search_providers/order_ahead_provider'

describe 'restaurant namespace rake task' do
  let(:all_providers) {ProviderIndex.providers}
  it "returns provider list" do
    expect(all_providers.class).to be Array
    expect(all_providers).to include "order_ahead"
  end

  describe "restaurant:get_core" do
    it "connects to each provider" do
      provider_responses = []
      all_providers.each do |provider_name|
        provider = ProviderIndex.send(provider_name)
        provider_responses << provider.is_provider?
      end

      expect(provider_responses.length).to eq all_providers.length
      expect(provider_responses).to_not include false
      expect(provider_responses).to include true
    end
  end
end
