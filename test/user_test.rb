require_relative 'test_helper'

describe "User class" do
  before do
    @new_user = User.new(
        id: "12333456",
        name: "PotatoBug",
        real_name: "Ms Potato Bug"
    )
  end

  describe "initialize" do

    it "is an instance of User" do

      expect(@new_user).must_be_instance_of User
    end

    it "must be kind of Builder" do

      expect(@new_user).must_be_kind_of Builder
    end

    it "returns the correct instance variables" do
      expect(@new_user.id).must_equal "12333456"
      expect(@new_user.name).must_equal "PotatoBug"
      expect(@new_user.real_name).must_equal "Ms Potato Bug"
    end
  end

  describe "details" do
    it "returns a string of user details" do
      user_details = @new_user.details

      expect(user_details).must_be_instance_of String
    end
  end

  describe "load_all" do
    it "returns an array of Class object" do
      VCR.use_cassette("user_list_all") do

        user_array = User.list_all

        expect(user_array).must_be_instance_of Array
        user_array.each do |user|
          _(user).must_be_instance_of User
        end
      end
    end
  end
end