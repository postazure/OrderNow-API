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

  desc "Order by historical data"
  task set_interval_order: :environment do
    day_of_week = Time.now.strftime("%A")
    hour_of_day = Time.now.strftime("%H")
    restaurants = Restaurant.all
    restaurants_with_redis = []
    restaurants.each do |restaurant|
      historic_wait_time_avg = $redis.get("#{restaurant.id}:#{day_of_week}:#{hour_of_day}:avg").to_i
      historic_wait_time_avg ||= 75
      restaurants_with_redis << {restaurant:restaurant, avg:historic_wait_time_avg}
    end
    ranks = []

    restaurants_with_redis.length.times do
      ranks << restaurants_with_redis.delete(restaurants_with_redis.min_by {|x| x[:avg]})
    end

    ranks.each_with_index do |rank, i|
      restaurant = rank[:restaurant]
      restaurant.update(interval_rank: i)
    end

  end
end
