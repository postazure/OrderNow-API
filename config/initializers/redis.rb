if Rails.env.production?
  $redis = Redis.new(:url => ENV["REDISCLOUD_URL"])
else
  $redis = Redis.new(host: "127.0.0.1", port: "6379")
end
