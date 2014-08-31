require 'test_helper'

class TweetsControllerTest < ActionController::TestCase
  setup do
    @tweet = tweets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tweets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tweet" do
    assert_difference('Tweet.count') do
      post :create, tweet: { expanded_urls: @tweet.expanded_urls, in_reply_to_status_id: @tweet.in_reply_to_status_id, in_reply_to_user_id: @tweet.in_reply_to_user_id, integer: @tweet.integer, retweeted_status_id: @tweet.retweeted_status_id, retweeted_status_timestamp: @tweet.retweeted_status_timestamp, retweeted_status_user_id: @tweet.retweeted_status_user_id, source: @tweet.source, text: @tweet.text, timestamp: @tweet.timestamp, tweet_id: @tweet.tweet_id }
    end

    assert_redirected_to tweet_path(assigns(:tweet))
  end

  test "should show tweet" do
    get :show, id: @tweet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tweet
    assert_response :success
  end

  test "should update tweet" do
    patch :update, id: @tweet, tweet: { expanded_urls: @tweet.expanded_urls, in_reply_to_status_id: @tweet.in_reply_to_status_id, in_reply_to_user_id: @tweet.in_reply_to_user_id, integer: @tweet.integer, retweeted_status_id: @tweet.retweeted_status_id, retweeted_status_timestamp: @tweet.retweeted_status_timestamp, retweeted_status_user_id: @tweet.retweeted_status_user_id, source: @tweet.source, text: @tweet.text, timestamp: @tweet.timestamp, tweet_id: @tweet.tweet_id }
    assert_redirected_to tweet_path(assigns(:tweet))
  end

  test "should destroy tweet" do
    assert_difference('Tweet.count', -1) do
      delete :destroy, id: @tweet
    end

    assert_redirected_to tweets_path
  end
end
