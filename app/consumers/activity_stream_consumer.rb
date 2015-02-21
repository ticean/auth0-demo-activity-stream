# Demo consumer that listens to ALL events and creates activity stream events.
#
# Publish to stream keys:
#
#   streams:global
#   streams:global:<user>
#   streams:<publisher>
#   streams:<publisher>:<user>
#
class ActivityStreamConsumer
  include Hutch::Consumer
  include Hutch::Logging
  consume '#' # firehose

  def process(message)
    app_id = message.properties[:app_id]
    uid = message[:actor][:uid]

    # Add some additional info per ActivityStreams spec.
    # see: http://activitystrea.ms/specs/json/1.0/
    activity = message.body.merge(
      generator: { client_id: message.properties[:app_id] },
      published: message.timestamp
    ).to_json
    $redis.pipelined do
      $redis.lpush("streams:_global", activity)
      $redis.lpush("streams:_global:#{uid}", activity)
      $redis.lpush("streams:#{app_id}", activity)
      $redis.lpush("streams:#{app_id}:#{uid}", activity)
    end
  rescue => e
    logger.error("Error processing message. \n#{e}")
  end
end
