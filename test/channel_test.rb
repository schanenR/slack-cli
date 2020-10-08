
require_relative 'test_helper'

describe "Channel class" do

  before do
    @new_channel = Channel.new( id: "1234",
                                name: "schanen",
                                topic: "general",
                                member_count: 456)
  end

  describe "initialize" do
    it "is an instance of Channel" do
      expect(@new_channel).must_be_instance_of Channel
    end

    it " is an kind of Builder" do
      expect(@new_channel).must_be_kind_of Builder
    end

    it "returns the correct instance variable values" do
      expect(@new_channel.id).must_equal "1234"
      expect(@new_channel.name).must_equal "schanen"
      expect(@new_channel.topic).must_equal "general"
      expect(@new_channel.member_count).must_equal 456
    end
  end

  describe "details" do
    it "returns a string of channel information" do
      channel_details = @new_channel.details
      expect(channel_details).must_be_instance_of String
    end
  end

  describe "list_all" do
    it "returns an array of Channel objects" do
      VCR.use_cassette("channel_list_all") do
        channel_array = Channel.list_all

        expect(channel_array).must_be_instance_of Array
        channel_array.each do |channel|
          _(channel).must_be_instance_of Channel
        end
      end
    end
  end
end