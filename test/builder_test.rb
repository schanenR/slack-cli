
require_relative 'test_helper'


describe "Builder class" do

  describe "initializer" do

    it "is an instance of builder" do
      new_builder = Builder.new(id: "1234", name: "foo")

      expect(new_builder).must_be_instance_of Builder
    end
  end

  describe "get" do


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

  describe "details" do
    it "raises NotImplementedError when called directly" do
      expect {
        Builder.details
      }.must_raise NotImplementedError

    end
  end

  describe "list_all" do
    it "raises NotImplementedError when called directly" do
      expect {
        Builder.list_all
      }.must_raise NotImplementedError
    end
  end

  describe "send a message" do
    it "sends a message to a user"
    sample_user = User.new(id: "U017ARD8DBM", name: "genevieve.hood", real_name: "Genevieve Neely")

    message = "Hi! What up Genevieve?!"

    VCR.use_cassette("user-message-test") do
      user_response = sample_user.send_message(message)

      expect(user_response["ok"]).must_equal true
      expect(user_response["message"]["text"]).must_equal message
    end
  end

  it " sends a message to a channel" do
    sample_channel = Channel.new(id: "C01ABK51G14", name: "test-channel2", topic: "", member_count: 15)

    message = "Hi! What up C14!?!"

    VCR.use_cassette("channel-message-test") do
      channel_response = sample_channel.send_message(message)

      expect(channel_response["ok"]).must_equal true
      expect(channel_response["message"]["text"]).must_equal message
    end
  end
end