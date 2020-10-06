require_relative 'test_helper'

describe "Builder class" do

  describe "initializer" do
    new_builder = Builder.new
    p new_builder
    expect(new_builder).must_be_instance_of Builder
  end

end