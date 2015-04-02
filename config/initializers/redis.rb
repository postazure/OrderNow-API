if Rails.env.production?
  services = JSON.parse(ENV['VCAP_SERVICES'])
  redis = services["redis-2.6"]
  credentials = redis.first["credentials"]
  host = credentials["host"]
  port = credentials["port"]
  password = credentials["password"]
  db = credentials["name"]

  # $redis = Redis.new(:url => ENV["REDISCLOUD_URL"])
  $redis = Redis.new(host: host, port:port, password:password, db:db)
else
  $redis = Redis.new(host: "127.0.0.1", port: "6379")
end
