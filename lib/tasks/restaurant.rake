require 'search_providers/search_provider'
require 'search_providers/order_ahead_provider'
require 'search_providers/provider_index'
# require 'harvesters/yelp_harvester'

namespace :restaurant do
  desc "Pull records data from restaurant search providers."
  task get_restaurants: :environment do
    providers = ProviderIndex.providers
    providers.each do |provider|
      restaurant_records = ProviderIndex.send(provider)
      ProviderIndex.save(restaurant_records)
    end
  end

  # desc "Pull yelp information from yelp api"
  # task get_yelp: :enviroment do
  #   db_restaurant = Restaurant.where.not(yelp_url: nil)
  #
  # end

  desc "For tests only"
  task test: :environment do
    $redis.set("test_key", "hello world")
    res = $redis.get("test_key")
    puts "#"*100
    p res
    puts "#"*100
  end
end
