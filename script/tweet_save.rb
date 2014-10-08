ENV["RAILS_ENV"] ||= "development"

root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
require File.join(root, "config", "environment")

def save(status)
  tweet = Tweet.new
  tweet.tweet_id = status.id
  tweet.in_reply_to_status_id = status.in_reply_to_status_id
  tweet.in_reply_to_user_id = status.in_reply_to_user_id
  tweet.timestamp = status.created_at
  s = status.source
  s =~ />(.+)<\//
  tweet.source = $+
  tweet.text = status.text
  tweet.save
end

client = Twitter::REST::Client.new do |config|
  config.consumer_key = CONSUMER_KEY
  config.consumer_secret = CONSUMER_SECRET
  config.access_token = ACCESS_TOKEN
  config.access_token_secret = ACCESS_TOKEN_SECRET
end
@user = client.user

TweetStream.configure do |config|
  config.consumer_key = CONSUMER_KEY
  config.consumer_secret = CONSUMER_SECRET
  config.oauth_token = ACCESS_TOKEN
  config.oauth_token_secret = ACCESS_TOKEN_SECRET
  config.auth_method = :oauth
end
daemon = TweetStream::Daemon.new('tweetstream', :log_output => true)

daemon.on_inited do
  ActiveRecord::Base.connection.reconnect!
  daemon_logger = Logger.new(File.join(Rails.root, "log", "stream.log"))
  Rails.logger = ActiveRecord::Base.logger = daemon_logger
  Rails.logger.debug "init"
end

daemon.userstream do |status|
  if @user.id == status.user.id
    Rails.logger.debug "save"
    save status
  end
end

daemon.on_error do |message|
  Rails.logger.debug message
end


