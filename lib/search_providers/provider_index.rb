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
    OrderAheadProvider.new(self.origin)
  end
end
