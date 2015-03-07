class ProviderIndex
  def self.providers
    [
      "order_ahead",
    ]
  end

  def self.order_ahead
    OrderAheadProvider.new
  end
end
