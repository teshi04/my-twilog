require 'csv'
require 'kconv'

class Tweet < ActiveRecord::Base

  def self.import_csv(csv_file)
    CSV.parse(Kconv.toutf8(csv_file.read)) do |row|

      tweet = Tweet.new
      tweet.tweet_id = row[0]
      tweet.in_reply_to_status_id = row[1]
      tweet.in_reply_to_user_id = row[2]
      tweet.timestamp = row[3]
      s = row[4]
      s =~ />(.+)<\//
      tweet.source =  $+
      tweet.text = row[5]
      tweet.retweeted_status_id = row[6]
      tweet.retweeted_status_user_id = row[7]
      tweet.retweeted_status_timestamp = row[8]
      tweet.expanded_urls = row[9]
      tweet.save
    end
  end
end
