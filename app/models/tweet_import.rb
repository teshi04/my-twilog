class TweetImport

  def import_csv(tweets_file)
    CSV.parse(Kconv.toutf8(tweets_file)) do |row, index|
      tweet = Tweet.new
      tweet.tweet_id = row[0]
      tweet.in_reply_to_status_id = row[1]
      tweet.in_reply_to_user_id = row[2]
      tweet.timestamp = row[3]
      tweet.source = row[4]
      tweet.text = row[5]
      tweet.retweeted_status_id = row[6]
      tweet.retweeted_status_user_id = row[7]
      tweet.retweeted_status_timestamp = row[8]
      tweet.expanded_urls = row[9]

      p "saved #{index}"
      tweet.save
    end
  end

end
