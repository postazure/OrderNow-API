require 'search_providers/search_provider'

namespace :restaurant do
  desc "Pull core data from restaurant search providers."
  task get_core: :environment do
    #loop through provider list
    #pull restaurants and populate DB
    providers = ProviderIndex.all
    providers.each do |provider|
      restaurant_records = ProviderIndex.send(provider)
      ProviderIndex.save(restaurant_records)
    end
  end
end
