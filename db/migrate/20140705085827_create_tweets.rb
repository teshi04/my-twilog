class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.text :tweet_id
      t.text :in_reply_to_status_id
      t.text :in_reply_to_user_id
      t.timestamp :timestamp
      t.text :source
      t.text :text
      t.text :retweeted_status_id
      t.text :retweeted_status_user_id
      t.timestamp :retweeted_status_timestamp
      t.text :expanded_urls

      t.timestamps
    end
  end
end
