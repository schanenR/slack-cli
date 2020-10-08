require_relative 'test_helper'

describe "Workspace class" do
  before do
    VCR.use_cassette("initialize_builder") do
      @new_workspace = Workspace.new
    end
  end

  describe "initialize" do

    it "is an instance of workspace" do

      expect(@new_workspace).must_be_instance_of Workspace
    end

    it"has an array of User objects in @users" do
      expect(@new_workspace.users).must_be_instance_of Array
      @new_workspace.users.each do |user|
        _(user).must_be_instance_of User
      end
    end

    it "has an array of Channel object in @channel" do
      expect(@new_workspace.channels).must_be_instance_of Array
      @new_workspace.channels.each do |channel|
        _(channel).must_be_instance_of Channel
      end
    end

    it "initializes with current_selection = nil" do
      current_selection = @new_workspace.current_selection
      expect(current_selection).must_be_nil
    end
  end

  describe "select_attribute" do
    it "updates @current_selection when passed with a valid name or id" do
      @new_workspace.select_attribute("C0165NC8LHH")
      channel = @new_workspace.channels.find { |channel| channel.id == "C0165NC8LHH"}

      expect(@new_workspace.current_selection).must_equal channel

      @new_workspace.select_attribute("genevieve.hood")
      user = @new_workspace.users.find { |user| user.name == "genevieve.hood" }

      expect(@new_workspace.current_selection).must_equal user
    end

    it "returns a confirmation message when a valid user/group is selected" do
      message = @new_workspace.select_attribute("C0165NC8LHH")
      message2 = @new_workspace.select_attribute("genevieve.hood")

      expect(message).must_equal "Selected Channel: fur-babes"
      expect(message2).must_equal "Selected User: genevieve.hood"
    end

    it "raises an argument error when called with an invalid name or id" do
      expect{
        @new_workspace.select_attribute("12345678901234567890")
      }.must_raise ArgumentError
    end
  end

  describe "show_details" do
    it "returns a string with info about the currently selected object" do
      @new_workspace.select_attribute("C0165NC8LHH")
      channel_details = @new_workspace.show_details
      @new_workspace.select_attribute("genevieve.hood")
      user_details = @new_workspace.show_details

      expect(channel_details).must_be_instance_of String
      expect(user_details).must_be_instance_of String
    end
  end

  describe "send_message" do
    it "sends a message to @current_selection" do
      VCR.use_cassette("chan_msg_workspace") do
        @new_workspace.select_attribute("C01ABK51G14")
        message = "Don't forget to take a screen break!!!!"
        response = @new_workspace.send_message(message)
        expect(response).must_equal "Message sent to Channel: test-channel2"
      end

      VCR.use_cassette("user_msg_workspace") do
        @new_workspace.select_attribute("genevieve.hood")
        message = "Don't forget to write your lightning talk!"
        response = @new_workspace.send_message(message)
        expect(response).must_equal "Message sent to User: genevieve.hood"
      end
    end

    it "raises an ArgumentError if a zero-length message is passed" do
      VCR.use_cassette("user_msg_workspace") do
        @new_workspace.select_attribute("genevieve.hood")
        expect{
          @new_workspace.send_message("")
        }.must_raise ArgumentError
      end
    end
  end
end