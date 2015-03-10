require 'search_providers/search_provider'

namespace :restaurant do
  desc "Pull records data from restaurant search providers."
  task get_restaurants: :environment do
    providers = ProviderIndex.all
    providers.each do |provider|
      restaurant_records = ProviderIndex.send(provider)
      ProviderIndex.save(restaurant_records)
    end
  end

  desc "Pull yelp information from yelp api"
  task get_yelp: :enviroment do
    db_restaurant = Restaurant.where.not(yelp_url: nil)
    
  end
end
