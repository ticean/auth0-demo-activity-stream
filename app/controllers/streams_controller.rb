class StreamsController < SecuredController

  def show
    key = stream_key(params[:app_id], params[:user_id])
    render text: $redis.lrange(key, 0, 49)
  end

  private

  def stream_key(app_id, user_id = nil)
    fail "app_id is required" unless app_id
    user_id ? "streams:#{app_id}:#{user_id}" : "streams:#{app_id}"
  end
end
