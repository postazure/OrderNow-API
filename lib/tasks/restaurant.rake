require 'search_providers/search_provider'
require 'search_providers/order_ahead_provider'
require 'search_providers/provider_index'
require 'harvesters/harvester_index'
require 'harvesters/yelp_harvester'

namespace :restaurant do
  desc "Pull records data from restaurant search providers."
  task get_restaurants: :environment do
    providers = ProviderIndex.providers
    providers.each do |provider|
      restaurant_records = ProviderIndex.send(provider)
      ProviderIndex.save(restaurant_records)
    end
  end

  desc "Runs as Harvesters"
  task get_harvesting: :environment do
    harvesters = HarvesterIndex.harvesters

    harvesters.each do |harvester|
      HarvesterIndex.send(harvester)
    end
  end

  desc "Pull yelp information from yelp api"
  task get_yelp: :environment do
    HarvesterIndex.yelp
  end
end
