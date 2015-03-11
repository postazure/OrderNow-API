class SearchProvider

  def search_by_location
    raise "Feature 'search_by_locaion' has not been implemented for this Provider"
  end

  def find_by_id
    raise "Feature 'find_by_id' has not been implemented for this Provider"
  end

  def get_json url
    begin
      puts "[get_json] Getting json from: #{url}"
      response = RestClient.get(url, user_agent: "chrome")
      JSON.parse(response.body)
    rescue
      puts "[get_json] ERROR: #{url}"

      # print "[get_json] Retrying API call in: "
      # timeout = 180 #seconds
      # timeout.times do |i|
      #   sleep(1.second)
      #    print "#{timeout-i}."
      # end
      # puts
      # get_json(url)
    end
  end
end
