class ProviderIndex

  def self.origin
    origin = Geocoder.search(94117).first
    origin.geometry["location"]
  end


  def self.providers
    [
      "order_ahead",
    ]
  end

  def self.order_ahead
    provider = OrderAheadProvider.new(self.origin)
    response = provider.search_by_location
    provider.to_restaurants(response)
  end
end
