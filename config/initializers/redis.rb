require 'redis'

# Expects ENV['REDIS_URL']
$redis = Redis.new
