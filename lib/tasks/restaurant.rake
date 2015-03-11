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

  desc "Pull yelp information from yelp api"
  task get_yelp: :environment do
    data = Restaurant.where.not(yelp_url: nil)
    YelpHarvester.insert(data)

  end

  desc "For tests only"
  task test: :environment do
    # REDIS
    # $redis.set("test_key", "hello world")
    # res = $redis.get("test_key")

    # YELP
    puts "#"*100
    res = Yelp.client.business('ovo-cafe-san-francisco')
    p res.categories
    p res.rating

    puts "#"*100
  end
end
