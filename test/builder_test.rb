require 'dotenv'
require 'vcr'
require_relative 'test_helper'
Dotenv.load
describe "Builder class" do

  describe "initializer" do

    it "is an instance of builder" do
      new_builder = Builder.new

      expect(new_builder).must_be_instance_of Builder
    end
  end

  describe "Builder#get" do


    it "Returns an Slack API get object" do
      VCR.use_cassette("user_query") do
        url = "https://slack.com/api/users.list"
        response = Builder.get(url, {token: ENV["SLACK_TOKEN"]})

        expect(response["ok"]).must_equal true
        expect(response).wont_be_nil
        expect(response["members"]).must_be_instance_of Array
      end
    end

    it "Returns a Slack API object for channel query" do
      VCR.use_cassette("channel_query") do
        url = "https://slack.com/api/conversations.list"
        response = Builder.get(url, {token: ENV["SLACK_TOKEN"]})

        expect(response["ok"]).must_equal true
        expect(response).wont_be_nil
        expect(response["channels"]).must_be_instance_of Array
      end
    end
  end
end