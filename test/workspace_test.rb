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
  end
end