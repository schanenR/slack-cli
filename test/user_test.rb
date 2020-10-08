
describe "User class" do

  describe "initialize" do

    before do
      @new_user = User.new(id: "123", name: "foo", real_name: "foo bar")
    end

    it "is an instance of User" do

      expect(@new_user).must_be_instance_of User
    end

    it "must be kind of Builder" do

      expect(@new_user).must_be_kind_of Builder
    end
  end



end