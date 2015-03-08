class SearchProvider
  
  def search_by_location
    raise "Feature 'search_by_locaion' has not been implemented for this Provider"
  end

  def find_by_id
    raise "Feature 'find_by_id' has not been implemented for this Provider"
  end

  def get_json url
    response = RestClient.get(url)
    JSON.parse(response.body)
  end
end
