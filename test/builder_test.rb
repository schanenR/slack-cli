require_relative 'test_helper'

describe "Builder class" do

  describe "initializer" do

    it "is an instance of builder" do
      new_builder = Builder.new

      expect(new_builder).must_be_instance_of Builder
    end
  end

end