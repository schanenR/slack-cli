


describe "Channel class" do

  describe "initialize" do

    before do
      @new_channel = Channel.new
    end

    it "is an instance of Channel" do
      expect(@new_channel).must_be_instance_of Channel
    end

    it " is an kind of Builder" do
      expect(@new_channel).must_be_kind_of Builder
    end

  end
end